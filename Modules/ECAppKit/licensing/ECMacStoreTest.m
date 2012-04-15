// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 17/11/2010
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECMacStoreTest.h"
#import "ECMacStoreReceipt.h"


@implementation ECMacStoreTest

// --------------------------------------------------------------------------
//! Initialise using the default url for the receipt file.
// --------------------------------------------------------------------------

- (id) init 
{
    if ((self = [super init]) != nil) 
    {
        unsigned char testGuid[] = { 0x00, 0x17, 0xf2, 0xc4, 0xbc, 0xc0 };		
        NSData* guid = [NSData dataWithBytes:testGuid length:sizeof(testGuid)];
        NSString* version = @"1.0.2";
        NSString* identifier = @"com.example.SampleApp";

        ECMacStoreReceipt* receipt = [[ECMacStoreReceipt alloc] initWithURL: [ECMacStore savedReceiptURLForGuid:guid]];
        if ([receipt isValidForGuid:guid identifier:identifier version:version])
        {
            self.status = @"Found MAS Test Receipt";
            self.receipt = receipt;
        }
        [receipt release];
    }
    
    return self;
}

@end
