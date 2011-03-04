// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 06/03/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "NSDictionary+ECUtilities.h"


@implementation NSDictionary(ECUtilities)

// --------------------------------------------------------------------------
//! If a given key is in the dictionary, place its value into a bool variable.
// --------------------------------------------------------------------------

- (id) valueForKey: (NSString*) key intoBool: (BOOL*) valueOut
{
	id value = [self valueForKey: key];
	if (value)
	{
		*valueOut = [value boolValue];
	}
	
	return value;
}

// --------------------------------------------------------------------------
//! If a given key is in the dictionary, place its value into a double variable.
// --------------------------------------------------------------------------

- (id) valueForKey: (NSString*) key intoDouble: (double*) valueOut
{
	id value = [self valueForKey: key];
	if (value)
	{
		*valueOut = [value doubleValue];
	}
	
	return value;
}

@end
