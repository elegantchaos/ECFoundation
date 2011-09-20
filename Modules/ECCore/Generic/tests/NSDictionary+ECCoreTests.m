// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//! @file:
//! Unit tests for the NSDictionary+ECUtilitiesTests.h category.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "NSDictionary+ECCoreTests.h"
#import "NSDictionary+ECCore.h"

@implementation NSDictionary_ECUtilitiesTests

// --------------------------------------------------------------------------
//! Set up before each test.
// --------------------------------------------------------------------------

- (void) setUp
{
	NSNumber* doubleNumber = [[NSNumber alloc] initWithDouble: 123.456];
	NSNumber* boolNumber = [[NSNumber alloc] initWithBool: YES];
	mDictionary = [[NSDictionary alloc] initWithObjectsAndKeys: doubleNumber, @"double", boolNumber, @"bool", nil];
	[doubleNumber release];
	[boolNumber release];
}

// --------------------------------------------------------------------------
//! Tear down after each test.
// --------------------------------------------------------------------------

- (void) tearDown
{
	[mDictionary release];
	mDictionary = nil;
}

// --------------------------------------------------------------------------
//! Test NSDictionary valueForKey: intoBool:
// --------------------------------------------------------------------------

- (void) testValueForKeyIntoBool
{
	BOOL value = NO;
	
	// try to get the bool value
	id object = [mDictionary valueForKey: @"bool" intoBool: &value];
	ECTestAssertNotNil(object, @"object returned");
	ECTestAssertTrue(value, @"value is correct");
	
	// try to get the double value as a bool - should work
	value = NO;
	object = [mDictionary valueForKey: @"double" intoBool: &value];
	ECTestAssertNotNil(object, @"object returned");
	ECTestAssertTrue(value, @"value is correct");

	// try to get non existant value
	value = NO;
	object = [mDictionary valueForKey: @"bogus" intoBool: &value];
	ECTestAssertNil(object, @"object not returned");
	ECTestAssertFalse(value, @"value is unchanged");
	
}

// --------------------------------------------------------------------------
//! Test NSDictionary valueForKey: intoDouble:
// --------------------------------------------------------------------------

- (void) testValueForKeyIntoDouble
{
	double value = 0.0;
	
	id object = [mDictionary valueForKey: @"double" intoDouble: &value];
	ECTestAssertNotNil(object, @"object returned");
	ECTestAssertTrue(value == 123.456, @"value is correct");

	// try to get the bool value as a double - should work
	value = 0.0;
	object = [mDictionary valueForKey: @"bool" intoDouble: &value];
	ECTestAssertNotNil(object, @"object returned");
	ECTestAssertTrue(value == 1.0, @"value is correct");
	
	// try to get non existant value
	value = NO;
	object = [mDictionary valueForKey: @"bogus" intoDouble: &value];
	ECTestAssertNil(object, @"object not returned");
	ECTestAssertFalse(value == 123.456, @"value is unchanged");
}

@end
