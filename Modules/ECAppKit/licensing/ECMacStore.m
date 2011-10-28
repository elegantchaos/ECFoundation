// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 17/11/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECMacStore.h"
#import "ECMacStoreReceipt.h"

#import "NSApplication+ECCore.h"
#import "ECMachine.h"
#import "ECKeychain.h"
#import "NSFileManager+ECCore.h"
#import "NSData+ECCore.h"

// link with Foundation.framework, IOKit.framework, Security.framework and libCrypto (via -lcrypto in Other Linker Flags)

@interface ECMacStore()


@end


@implementation ECMacStore

@synthesize receipt;
@synthesize status;

// --------------------------------------------------------------------------
//! Clean up.
// --------------------------------------------------------------------------

- (void) dealloc
{
    [receipt release];
    [status release];
    
    [super dealloc];
}

// --------------------------------------------------------------------------
//! Is our license (receipt) file valid?
// --------------------------------------------------------------------------

- (BOOL) isValid
{
    return self.status != nil;
}

// --------------------------------------------------------------------------
//! Return a dictionary containing license information.
// --------------------------------------------------------------------------

- (NSDictionary*) info
{
    return self.receipt.info;
}


// --------------------------------------------------------------------------
//! Return the location that we expect the application store receipt to be at.
// --------------------------------------------------------------------------

+ (NSURL*) defaultReceiptURL;
{
    NSBundle* bundle = [NSBundle mainBundle]; 
    
    NSURL* url = [bundle bundleURL];
    url = [url URLByAppendingPathComponent: @"Contents/_MASReceipt/Receipt"];
    
    return url;
}

// --------------------------------------------------------------------------
//! Return the location where a copy of the receipt should be saved, assuming
//! that the app has been run with a valid receipt at least once.
// --------------------------------------------------------------------------

+ (NSURL*) savedReceiptURLForGuid:(NSData*)guid;
{
    NSFileManager* fm = [NSFileManager defaultManager];
    NSURL* receiptsFolder = [fm URLForApplicationDataPath:@"Receipts"];

    NSString* guidHex = [guid hexString];
    NSURL* receiptURL = [receiptsFolder URLByAppendingPathComponent: guidHex];
    
    return receiptURL;
}

@end
