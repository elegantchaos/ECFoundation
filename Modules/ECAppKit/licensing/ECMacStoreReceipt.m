// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 02/08/2011
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//
// based on  validatereceipt.m:
//
//  Created by Ruotger Skupin on 23.10.10.
//  Copyright 2010 Matthew Stevens, Ruotger Skupin, Apple, Dave Carlton, Fraser Hess, anlumo. All rights reserved.
// --------------------------------------------------------------------------

#import "ECMacStoreReceipt.h"
#import "ECKeychain.h"

// link with Foundation.framework, IOKit.framework, Security.framework and libCrypto (via -lcrypto in Other Linker Flags)

#import <IOKit/IOKitLib.h>
#import <Foundation/Foundation.h>

#import <Security/Security.h>

#include <openssl/pkcs7.h>
#include <openssl/objects.h>
#include <openssl/sha.h>
#include <openssl/x509.h>
#include <openssl/err.h>

NSString *const kReceiptBundleIdentifer = @"BundleIdentifier";
NSString *const kReceiptBundleIdentiferData = @"BundleIdentifierData";
NSString *const kReceiptVersion = @"Version";
NSString *const kReceiptOpaqueValue = @"OpaqueValue";
NSString *const kReceiptHash = @"Hash";

@interface ECMacStoreReceipt()

+ (NSDictionary*) dictionaryFromReceiptAtURL: (NSURL*) url;

@end


@implementation ECMacStoreReceipt

@synthesize info;

// --------------------------------------------------------------------------
//! Initialise using a receipt file.
// --------------------------------------------------------------------------

- (id)initWithURL:(NSURL*)url;
{
    if ((self = [super init]) != nil) 
    {
        self.info = [ECMacStoreReceipt dictionaryFromReceiptAtURL:url];
    }

    return self;
}

// --------------------------------------------------------------------------
//! Clean up.
// --------------------------------------------------------------------------

- (void) dealloc
{
    [info release];
    
    [super dealloc];
}

// --------------------------------------------------------------------------
//! Check the receipt matches a given guid, identifier and version
//! Returns YES if it is valid.
// --------------------------------------------------------------------------

- (BOOL)isValidForGuid:(NSData*)guid identifier:(NSString*)identifier version:(NSString*)version;
{
	NSMutableData *input = [NSMutableData data];
	[input appendData:guid];
	[input appendData:[self.info objectForKey:kReceiptOpaqueValue]];
	[input appendData:[self.info objectForKey:kReceiptBundleIdentiferData]];
	
	NSMutableData *hash = [NSMutableData dataWithLength:SHA_DIGEST_LENGTH];
	SHA1([input bytes], [input length], [hash mutableBytes]);
	
	if ([identifier isEqualToString:[self.info objectForKey:kReceiptBundleIdentifer]] &&
		[version isEqualToString:[self.info objectForKey:kReceiptVersion]] &&
		[hash isEqualToData:[self.info objectForKey:kReceiptHash]]) 
	{
		return YES;
	}
	
	return NO;
}

// --------------------------------------------------------------------------
//! Check the receipt matches a given guid, and identifier.
//! We allow the version to be different.
//! Returns YES if it is valid.
// --------------------------------------------------------------------------

- (BOOL)isValidForGuid:(NSData*)guid identifier:(NSString*)identifier;
{
	NSMutableData *input = [NSMutableData data];
	[input appendData:guid];
	[input appendData:[self.info objectForKey:kReceiptOpaqueValue]];
	[input appendData:[self.info objectForKey:kReceiptBundleIdentiferData]];
	
	NSMutableData *hash = [NSMutableData dataWithLength:SHA_DIGEST_LENGTH];
	SHA1([input bytes], [input length], [hash mutableBytes]);
	
	if ([identifier isEqualToString:[self.info objectForKey:kReceiptBundleIdentifer]] &&
		[hash isEqualToData:[self.info objectForKey:kReceiptHash]]) 
	{
		return YES;
	}
	
	return NO;
}


// --------------------------------------------------------------------------
//! Return dictionary containing data from the receipt.
// --------------------------------------------------------------------------

+ (NSDictionary*) dictionaryFromReceiptAtURL: (NSURL*) url
{
	NSData * rootCertData = [ECKeychain appleRootCertificate];
	
    enum ATTRIBUTES 
	{
        ATTR_START = 1,
        BUNDLE_ID,
        VERSION,
        OPAQUE_VALUE,
        HASH,
        ATTR_END
    };
    
	ERR_load_PKCS7_strings();
	ERR_load_X509_strings();
	OpenSSL_add_all_digests();
	
    // Expected input is a PKCS7 container with signed data containing
    // an ASN.1 SET of SEQUENCE structures. Each SEQUENCE contains
    // two INTEGERS and an OCTET STRING.
    
    NSString* path = [url path];
	const char * receiptPath = [[path stringByStandardizingPath] fileSystemRepresentation];
    FILE *fp = fopen(receiptPath, "rb");
    if (fp == NULL)
        return nil;
    
    PKCS7 *p7 = d2i_PKCS7_fp(fp, NULL);
    fclose(fp);
    
    if (!PKCS7_type_is_signed(p7)) {
        PKCS7_free(p7);
        return nil;
    }
    
    if (!PKCS7_type_is_data(p7->d.sign->contents)) {
        PKCS7_free(p7);
        return nil;
    }
    
	BIO *payload = BIO_new(BIO_s_mem());
	X509_STORE *store = X509_STORE_new();
	
	unsigned char const *data = (unsigned char const *)(rootCertData.bytes);
	X509 *appleCA = d2i_X509(NULL, &data, rootCertData.length);
	
	X509_STORE_add_cert(store, appleCA);
	
	int verifyReturnValue = PKCS7_verify(p7,NULL,store,NULL,payload,0);
	
	// this code will come handy when the first real receipts arrive
#if 0
	unsigned long err = ERR_get_error();
	if(err)
		printf("%lu: %s\n",err,ERR_error_string(err,NULL));
	else {
		STACK_OF(X509) *stack = PKCS7_get0_signers(p7, NULL, 0);
		for(NSUInteger i = 0; i < sk_num(stack); i++) {
			const X509 *signer = (X509*)sk_value(stack, i);
			NSLog(@"name = %s", signer->name);
		}
	}
#endif
	
	X509_STORE_free(store);
	EVP_cleanup();
	
	if (verifyReturnValue != 1)
	{
        PKCS7_free(p7);
		return nil;	
	}
	
    ASN1_OCTET_STRING *octets = p7->d.sign->contents->d.data;   
    const unsigned char *p = octets->data;
    const unsigned char *end = p + octets->length;
    
    int type = 0;
    int xclass = 0;
    long length = 0;
    
    ASN1_get_object(&p, &length, &type, &xclass, end - p);
    if (type != V_ASN1_SET) {
        PKCS7_free(p7);
        return nil;
    }
    
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    
    while (p < end) {
        ASN1_get_object(&p, &length, &type, &xclass, end - p);
        if (type != V_ASN1_SEQUENCE)
            break;
        
        const unsigned char *seq_end = p + length;
        
        int attr_type = 0;
        int attr_version = 0;
        
        // Attribute type
        ASN1_get_object(&p, &length, &type, &xclass, seq_end - p);
        if (type == V_ASN1_INTEGER && length == 1) {
            attr_type = p[0];
        }
        p += length;
        
        // Attribute version
        ASN1_get_object(&p, &length, &type, &xclass, seq_end - p);
        if (type == V_ASN1_INTEGER && length == 1) {
            attr_version = p[0];
			attr_version = attr_version;
        }
        p += length;
        
        // Only parse attributes we're interested in
        if (attr_type > ATTR_START && attr_type < ATTR_END) {
            NSString *key;
            
            ASN1_get_object(&p, &length, &type, &xclass, seq_end - p);
            if (type == V_ASN1_OCTET_STRING) {
                
                // Bytes
                if (attr_type == BUNDLE_ID || attr_type == OPAQUE_VALUE || attr_type == HASH) {
                    NSData *data = [NSData dataWithBytes:p length:length];
                    
                    switch (attr_type) {
                        case BUNDLE_ID:
                            // This is included for hash generation
                            key = kReceiptBundleIdentiferData;
                            break;
                        case OPAQUE_VALUE:
                            key = kReceiptOpaqueValue;
                            break;
                        case HASH:
                            key = kReceiptHash;
                            break;
                    }
                    
                    [info setObject:data forKey:key];
                }
                
                // Strings
                if (attr_type == BUNDLE_ID || attr_type == VERSION) {
                    int str_type = 0;
                    long str_length = 0;
                    const unsigned char *str_p = p;
                    ASN1_get_object(&str_p, &str_length, &str_type, &xclass, seq_end - str_p);
                    if (str_type == V_ASN1_UTF8STRING) {
                        NSString *string = [[[NSString alloc] initWithBytes:str_p
                                                                     length:str_length
                                                                   encoding:NSUTF8StringEncoding] autorelease];
						
                        switch (attr_type) {
                            case BUNDLE_ID:
                                key = kReceiptBundleIdentifer;
                                break;
                            case VERSION:
                                key = kReceiptVersion;
                                break;
                        }
                        
                        [info setObject:string forKey:key];
                    }
                }
            }
            p += length;
        }
        
        // Skip any remaining fields in this SEQUENCE
        while (p < seq_end) {
            ASN1_get_object(&p, &length, &type, &xclass, seq_end - p);
            p += length;
        }
    }
    
    PKCS7_free(p7);
    
    return info;
}


@end
