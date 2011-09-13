// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 17/11/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECLicenseChecker.h"

@class ECMacStoreReceipt;

@interface ECMacStore : ECLicenseChecker
{
@private
    
    // --------------------------------------------------------------------------
    // Member Variables
    // --------------------------------------------------------------------------

    ECMacStoreReceipt* receipt;
    NSString* status;
}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

@property (nonatomic, retain) ECMacStoreReceipt* receipt;
@property (nonatomic, retain) NSString* status;

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (BOOL)            isValid;
- (NSDictionary*)   info;

+ (NSURL*) defaultReceiptURL;
+ (NSURL*) savedReceiptURLForGuid:(NSData*)guid;


@end
