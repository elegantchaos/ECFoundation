//
//  ECCompoundLicenseChecker.h
//  ECAppKit
//
//  Created by Sam Deane on 13/03/2011.
//  Copyright 2011 Elegant Chaos. All rights reserved.
//

#import "ECLicenseChecker.h"

#import <ECFoundation/ECProperties.h>

@interface ECCompoundLicenseChecker : ECLicenseChecker 
{
    ECPropertyVariable(checkers, NSMutableArray*);
}

ECPropertyRetained(checkers, NSMutableArray*);

- (BOOL)            isValid;
- (NSDictionary*)   info;
- (NSString*)       user;
- (NSString*)       email;
- (NSString*)       status;
- (BOOL)            importLicenseFromURL: (NSURL*) url;

- (void)            addChecker:(ECLicenseChecker*) checker;


@end
