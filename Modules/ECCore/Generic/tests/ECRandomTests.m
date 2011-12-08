// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//! @file:
//! Unit tests for the NSDate+ECUtilitiesTests.h category.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTestCase.h"
#import "ECRandom.h"


@interface ECRandomTests : ECTestCase

@end

@implementation ECRandomTests

static const NSUInteger kIterations = 100;
static const double kSmallDouble = 1.0;
static const double kLargeDouble = 100000000.0;
static const NSInteger kSmallInteger = 1;
static const NSInteger kLargeInteger = LONG_MAX;

- (void)testDoubles
{
	// we don't try to test random distribution here, just test the bounds of the result
	for (NSUInteger n = 0; n < kIterations; ++n)
	{
		ECTestAssertRealIsGreaterEqual([ECRandom randomDoubleFromZeroTo:kSmallDouble], 0.0);
		ECTestAssertRealIsLessEqual([ECRandom randomDoubleFromZeroTo:kSmallDouble], kSmallDouble);
		ECTestAssertRealIsGreaterEqual([ECRandom randomDoubleFromZeroTo:kLargeDouble], 0.0);
		ECTestAssertRealIsLessEqual([ECRandom randomDoubleFromZeroTo:kLargeDouble], kLargeDouble);

		ECTestAssertRealIsGreaterEqual([ECRandom randomDoubleFrom:-kSmallDouble to:kLargeDouble], -kSmallDouble);
		ECTestAssertRealIsLessEqual([ECRandom randomDoubleFrom:-kSmallDouble to:kLargeDouble], kLargeDouble);
	}

	ECTestAssertRealIsEqual([ECRandom randomDoubleFromZeroTo:0.0], 0.0);
	ECTestAssertRealIsEqual([ECRandom randomDoubleFrom:kSmallDouble to:kSmallDouble], kSmallDouble);

}

- (void)testIntegers
{
	// we don't try to test random distribution here, just test the bounds of the result
	for (NSUInteger n = 0; n < kIterations; ++n)
	{
		ECTestAssertIsGreaterEqual([ECRandom randomIntegerFromZeroTo:kSmallInteger], 0);
		ECTestAssertIsLessEqual([ECRandom randomIntegerFromZeroTo:kSmallInteger], kSmallInteger);
		ECTestAssertIsGreaterEqual([ECRandom randomIntegerFromZeroTo:kLargeInteger], 0);
		ECTestAssertIsLessEqual([ECRandom randomIntegerFromZeroTo:kLargeInteger], kLargeInteger);

		ECTestAssertIsGreaterEqual([ECRandom randomIndexFromRangeSized:kSmallInteger], 0);
		ECTestAssertIsLess([ECRandom randomIndexFromRangeSized:kSmallInteger], kSmallInteger);
		ECTestAssertIsGreaterEqual([ECRandom randomIndexFromRangeSized:kLargeInteger], 0);
		ECTestAssertIsLess([ECRandom randomIndexFromRangeSized:kLargeInteger], kLargeInteger);

		ECTestAssertIsGreaterEqual([ECRandom randomIntegerBelow:kSmallInteger], 0);
		ECTestAssertIsLess([ECRandom randomIntegerBelow:kSmallInteger], kSmallInteger);
		ECTestAssertIsGreaterEqual([ECRandom randomIntegerBelow:kLargeInteger], 0);
		ECTestAssertIsLess([ECRandom randomIntegerBelow:kLargeInteger], kLargeInteger);

		ECTestAssertIsGreaterEqual([ECRandom randomIntegerFrom:-kSmallInteger to:kLargeInteger], -kSmallInteger);
		ECTestAssertIsLessEqual([ECRandom randomIntegerFrom:-kSmallInteger to:kLargeInteger], kLargeInteger);
		
	}

	ECTestAssertIsEqual([ECRandom randomIntegerFromZeroTo:0], 0);
	ECTestAssertIsEqual([ECRandom randomIndexFromRangeSized:1], 0);
	ECTestAssertIsEqual([ECRandom randomIntegerBelow:1], 0);
	ECTestAssertIsEqual([ECRandom randomIntegerFrom:kSmallInteger to:kSmallInteger], kSmallInteger);
}

- (void)testChance
{
	ECTestAssertFalse([ECRandom randomChance:0.0]);
	ECTestAssertTrue([ECRandom randomChance:1.0]);
}

@end
