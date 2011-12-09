// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 13/03/2011
//
//! @file Keychain utilities
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECKeychain.h"

@implementation ECKeychain

// --------------------------------------------------------------------------
//! Return the apple root certificate.
// --------------------------------------------------------------------------

+ (NSData*) appleRootCertificate
{
	OSStatus status;
	
	SecKeychainRef keychain = nil;
	status = SecKeychainOpen("/System/Library/Keychains/SystemRootCertificates.keychain", &keychain);
	if(status) {
		if(keychain) CFRelease(keychain);
		return nil;
	}
	
	CFArrayRef searchList = CFArrayCreate(kCFAllocatorDefault, (const void**)&keychain, 1, &kCFTypeArrayCallBacks);
	
	if (keychain)
		CFRelease(keychain);
	
	SecKeychainSearchRef searchRef = nil;
	status = SecKeychainSearchCreateFromAttributes(searchList, kSecCertificateItemClass, NULL, &searchRef);
	if(status) {
		if(searchRef) CFRelease(searchRef);
		if(searchList) CFRelease(searchList);
		return nil;
	}
	
	SecKeychainItemRef itemRef = nil;
	NSData * resultData = nil;
	
	while(SecKeychainSearchCopyNext(searchRef, &itemRef) == noErr && resultData == nil) {
		// Grab the name of the certificate
		SecKeychainAttributeList list;
		SecKeychainAttribute attributes[1];
		
		attributes[0].tag = kSecLabelItemAttr;
		
		list.count = 1;
		list.attr = attributes;
		
		SecKeychainItemCopyContent(itemRef, nil, &list, nil, nil);
		NSData *nameData = [NSData dataWithBytesNoCopy:attributes[0].data length:attributes[0].length freeWhenDone:NO];
		NSString *name = [[NSString alloc] initWithData:nameData encoding:NSUTF8StringEncoding];
		
		if([name isEqualToString:@"Apple Root CA"]) {
			CSSM_DATA certData;
			status = SecCertificateGetData((SecCertificateRef)itemRef, &certData);
			if(status) {
				if(itemRef) CFRelease(itemRef);
			}
			
			resultData = [NSData dataWithBytes:certData.Data length:certData.Length];
			
			SecKeychainItemFreeContent(&list, NULL);
			if(itemRef) CFRelease(itemRef);
		}
		
        [name release];
	}
	CFRelease(searchList);
	CFRelease(searchRef);
	
	return resultData;
}

@end
