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

#import "NSString+ECCore.h"
#import "ECTestCase.h"


@interface NSStringTests : ECTestCase
{
}

@end

@implementation NSStringTests

// --------------------------------------------------------------------------
//! Set up before each test.
// --------------------------------------------------------------------------

- (void) setUp
{
}

// --------------------------------------------------------------------------
//! Tear down after each test.
// --------------------------------------------------------------------------

- (void) tearDown
{
}

// --------------------------------------------------------------------------
//! Test NSDictionary valueForKey: intoBool:
// --------------------------------------------------------------------------

- (void) testSplitWordsIntoInts
{
	NSString* string = [NSString stringWithString: @"1 2 3 4 5 -1 -2 -3 -4 -5"];
	
	NSData* data = [string splitWordsIntoInts];
	
	ECTestAssertTrue([data length] == sizeof(int) * 10);
	
	const int* ints = [data bytes];
	for (int n = 0; n < 10; ++n)
	{
		int expected = (n < 5) ? n + 1 : 4 - n;
		ECTestAssertTrue(ints[n] == expected);
	}
	
}

@end
