//
//  ECCompoundLicenseChecker.m
//  <ECFoundation/
//
//  Created by Sam Deane on 13/03/2011.
//  Copyright 2011 Elegant Chaos. All rights reserved.
//

#import "ECCompoundLicenseChecker.h"


@implementation ECCompoundLicenseChecker

@synthesize checkers;

- (id) init 
{
    if ((self = [super init]) != nil) 
    {
        self.checkers = [NSMutableArray array];
    }
    
    return self;
}

- (void) dealloc
{
	[checkers release];
    
    [super dealloc];
}

- (BOOL) isValid
{
    for (ECLicenseChecker* checker in self.checkers)
    {
        if ([checker isValid])
            return YES;
    }
    
    return NO;
}

- (NSDictionary*) info
{
    for (ECLicenseChecker* checker in self.checkers)
    {
        if ([checker isValid])
        {
            return [checker info];
        }
    }

    return nil;
}

- (NSString*) user;
{
    for (ECLicenseChecker* checker in self.checkers)
    {
        if ([checker isValid])
        {
            return [checker user];
        }
    }
    
    return nil;
}

- (NSString*) email;
{
    for (ECLicenseChecker* checker in self.checkers)
    {
        if ([checker isValid])
        {
            return [checker email];
        }
    }
    
    return nil;
}

- (NSString*) status;
{
    for (ECLicenseChecker* checker in self.checkers)
    {
        if ([checker isValid])
        {
            return [checker status];
        }
    }
    
    return @"Trial Version - Unregistered";
}

- (BOOL) importLicenseFromURL: (NSURL*) url;
{
    for (ECLicenseChecker* checker in self.checkers)
    {
        if ([checker importLicenseFromURL:url])
        {
            return YES;
        }
    }
    
    return NO;
}


- (void) addChecker:(ECLicenseChecker *)checker
{
    [self.checkers addObject:checker];
}

@end
