// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 17/11/2010
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECMacStoreExact.h"
#import "ECMacStoreReceipt.h"
#import "ECMachine.h"


@implementation ECMacStoreExact

// --------------------------------------------------------------------------
//! Initialise using the default url for the receipt file.
// --------------------------------------------------------------------------

- (id) init 
{
    if ((self = [super init]) != nil) 
    {
        // do we have an exact match with a receipt inside our bundle?
        NSString* version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        NSString* identifier = [[NSBundle mainBundle] bundleIdentifier];
        NSData* guid = [ECMachine machineAddress];
        if (guid)
        {
            NSURL* receiptURL = [ECMacStore defaultReceiptURL];
            ECMacStoreReceipt* receipt = [[ECMacStoreReceipt alloc] initWithURL: receiptURL];
            if ([receipt isValidForGuid:guid identifier:identifier version:version])
            {
                self.status = @"Mac Store Edition";
                self.receipt = receipt;
            }
            [receipt release];
            
            // save a copy of the receipt into the application data folder
            NSURL* copyURL = [ECMacStore savedReceiptURLForGuid:guid];
            NSError* error = nil;
            [[NSFileManager defaultManager] copyItemAtURL:receiptURL toURL:copyURL error:&error];
        }
    }

    return self;
}

@end
