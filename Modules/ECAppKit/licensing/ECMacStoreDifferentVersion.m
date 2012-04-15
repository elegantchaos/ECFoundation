// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 17/11/2010
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECMacStoreDifferentVersion.h"
#import "ECMacStoreReceipt.h"

#import "ECMachine.h"


@implementation ECMacStoreDifferentVersion

// --------------------------------------------------------------------------
//! Initialise using the default url for the receipt file.
// --------------------------------------------------------------------------

- (id) init 
{
    if ((self = [super init]) != nil) 
    {
        // do we have an match with a receipt saved in the application data folder, which might have a different version
        NSString* identifier = [[NSBundle mainBundle] bundleIdentifier];
        NSData* guid = [ECMachine machineAddress];
        if (guid)
        {
            ECMacStoreReceipt* receipt = [[ECMacStoreReceipt alloc] initWithURL: [ECMacStore savedReceiptURLForGuid:guid]];
            if ([receipt isValidForGuid:guid identifier:identifier])
            {
                self.status = @"Indy Edition (Older MAS Found)";
                self.receipt = receipt;
            }
            [receipt release];
        }
    }
    
    return self;
}

@end
