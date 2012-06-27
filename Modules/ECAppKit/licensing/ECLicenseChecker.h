// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 13/03/2011
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

@interface ECLicenseChecker : NSObject

- (BOOL)            isValid;
- (NSDictionary*)   info;
- (NSString*)       user;
- (NSString*)       email;
- (NSString*)       status;
- (BOOL)            importLicenseFromURL: (NSURL*) url;
- (void)            registerLicenseFile: (NSURL*) licenseURL;
- (void)            chooseLicenseFile;

@end
