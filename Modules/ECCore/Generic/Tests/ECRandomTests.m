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
		ECTestAssertIntegerIsGreaterEqual([ECRandom randomIntegerFromZeroTo:kSmallInteger], 0);
		ECTestAssertIntegerIsLessEqual([ECRandom randomIntegerFromZeroTo:kSmallInteger], kSmallInteger);
		ECTestAssertIntegerIsGreaterEqual([ECRandom randomIntegerFromZeroTo:kLargeInteger], 0);
		ECTestAssertIntegerIsLessEqual([ECRandom randomIntegerFromZeroTo:kLargeInteger], kLargeInteger);

		ECTestAssertIntegerIsGreaterEqual([ECRandom randomIndexFromRangeSized:kSmallInteger], 0);
		ECTestAssertIntegerIsLess([ECRandom randomIndexFromRangeSized:kSmallInteger], (NSUInteger) kSmallInteger);
		ECTestAssertIntegerIsGreaterEqual([ECRandom randomIndexFromRangeSized:kLargeInteger], 0);
		ECTestAssertIntegerIsLess([ECRandom randomIndexFromRangeSized:kLargeInteger], (NSUInteger) kLargeInteger);

		ECTestAssertIntegerIsGreaterEqual([ECRandom randomIntegerBelow:kSmallInteger], 0);
		ECTestAssertIntegerIsLess([ECRandom randomIntegerBelow:kSmallInteger], kSmallInteger);
		ECTestAssertIntegerIsGreaterEqual([ECRandom randomIntegerBelow:kLargeInteger], 0);
		ECTestAssertIntegerIsLess([ECRandom randomIntegerBelow:kLargeInteger], kLargeInteger);

		ECTestAssertIntegerIsGreaterEqual([ECRandom randomIntegerFrom:-kSmallInteger to:kLargeInteger], -kSmallInteger);
		ECTestAssertIntegerIsLessEqual([ECRandom randomIntegerFrom:-kSmallInteger to:kLargeInteger], kLargeInteger);
		
	}

	ECTestAssertIntegerIsEqual([ECRandom randomIntegerFromZeroTo:0], 0);
	ECTestAssertIntegerIsEqual([ECRandom randomIndexFromRangeSized:1], 0);
	ECTestAssertIntegerIsEqual([ECRandom randomIntegerBelow:1], 0);
	ECTestAssertIntegerIsEqual([ECRandom randomIntegerFrom:kSmallInteger to:kSmallInteger], kSmallInteger);
}

- (void)testChance
{
	ECTestAssertFalse([ECRandom randomChance:0.0]);
	ECTestAssertTrue([ECRandom randomChance:1.0]);
}

@end
