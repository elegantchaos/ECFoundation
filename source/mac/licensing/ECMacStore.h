// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 17/11/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECLicenseChecker.h"

#import <ECFoundation/ECProperties.h>

extern NSString *const kReceiptBundleIdentifer;
extern NSString *const kReceiptBundleIdentiferData;
extern NSString *const kReceiptVersion;
extern NSString *const kReceiptOpaqueValue;
extern NSString *const kReceiptHash;

@interface ECMacStore : ECLicenseChecker
{
@private
    
    // --------------------------------------------------------------------------
    // Member Variables
    // --------------------------------------------------------------------------

    ECPropertyVariable(url, NSURL*);
}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

ECPropertyRetained(url, NSURL*);

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

+ (NSURL*)          defaultReceiptURL;
+ (BOOL)            validateReceiptAtURL: (NSURL*) url;
+ (NSDictionary*)   dictionaryFromReceiptAtURL: (NSURL*) url;

- (id)              init;
- (BOOL)            isValid;
- (NSDictionary*)   info;
- (NSString*)       status;


@end
