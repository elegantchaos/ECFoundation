//
//  ECCompoundLicenseChecker.h
//  ECAppKit
//
//  Created by Sam Deane on 13/03/2011.
//  Copyright 2011 Elegant Chaos. All rights reserved.
//

#import "ECLicenseChecker.h"

@interface ECCompoundLicenseChecker : ECLicenseChecker 
{
	NSMutableArray* checkers;
}

@property (nonatomic, retain) NSMutableArray* checkers;

- (BOOL)            isValid;
- (NSDictionary*)   info;
- (NSString*)       user;
- (NSString*)       email;
- (NSString*)       status;
- (BOOL)            importLicenseFromURL: (NSURL*) url;

- (void)            addChecker:(ECLicenseChecker*) checker;


@end
