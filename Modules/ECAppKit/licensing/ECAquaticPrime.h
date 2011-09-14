// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 02/09/2010
//
//! @file Licensing support for ECAquaticPrime
//!
//! NB this file isn't included directly in the <ECFoundation/ framework,
//!    to prevent us depending on Aquatic Prime.
//!    To use this class, add ECAquaticPrime.m to your project.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECLicenseChecker.h"

@interface ECAquaticPrime : ECLicenseChecker

- (id) initWithKey: (NSString*) key;
- (BOOL) importLicenseFromURL: (NSURL*) url;
- (void) clearLicense;
- (NSData*) licenseData;
- (BOOL) isValid;
- (NSDictionary*) info;
- (NSString*) user;
- (NSString*) email;
- (NSString*) status;
@end
