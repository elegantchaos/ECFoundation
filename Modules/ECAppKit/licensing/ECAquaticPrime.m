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
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECAquaticPrime.h"

#include "AquaticPrime.h"

@implementation ECAquaticPrime

- (id) initWithKey: (NSString*) key
{
	if ((self = [super init]) != nil)
	{
		APSetKey((CFStringRef) key);
	}
	
	return self;
}

- (BOOL) importLicenseFromURL: (NSURL*) url
{
	NSData* data = [NSData dataWithContentsOfURL: url];
	BOOL valid = APVerifyLicenseData((CFDataRef) data);
	if (valid)
	{
		[[NSUserDefaults standardUserDefaults] setValue: data forKey: @"License"];
	}
	return valid;
}

- (void) clearLicense
{
	[[NSUserDefaults standardUserDefaults] removeObjectForKey: @"License"];

}

- (NSData*) licenseData
{
	NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey: @"License"];
	
	return data;
}
- (BOOL) isValid
{
	return APVerifyLicenseData((CFDataRef) [self licenseData]);
}

- (NSDictionary*) info
{
	NSDictionary* info = (NSDictionary*) APCreateDictionaryForLicenseData((CFDataRef) [self licenseData]);
	
	return [info autorelease];
}

- (NSString*) user
{
	NSString* user = nil;

	NSDictionary* info = [self info];
	if (info)
	{
		user = [info objectForKey: @"Name"];
	}
	
	return user;
}

- (NSString*) email
{
	NSString* email = nil;
	
	NSDictionary* info = [self info];
	if (info)
	{
		email = [info objectForKey: @"Email"];
	}
	
	return email;	
}

- (NSString*) status
{
    NSString* status;
    
    if ([self isValid])
    {
        NSDictionary* info = [self info];
        status = [NSString stringWithFormat: @"Licensed to %@ (%@)", [info objectForKey: @"Name"], [info objectForKey: @"Email"]];
    }
    else
    {
        status = [super status];
    }
    
    return status;
}


@end
