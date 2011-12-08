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

- (void)testDoubles
{
	for (NSUInteger n = 0; n < kIterations; ++n)
	{
		ECTestAssertRealIsGreaterEqual([ECRandom randomDoubleFromZeroTo:kSmallDouble], 0.0);
	}
}

#if 0
+ (double)randomDoubleFromZeroTo:(double)to;
+ (double)randomDoubleFromZeroTo:(double)to resolution:(double)resolution;
+ (NSInteger)randomIntegerFromZeroTo:(NSInteger)to;
+ (NSInteger)randomIntegerBelow:(NSInteger)to;

+ (double)randomDoubleFrom:(double)from to:(double)to;
+ (double)randomDoubleFrom:(double)from to:(double)to resolution:(double)resolution;
+ (NSInteger)randomIntegerFrom:(NSInteger)from to:(NSInteger)to;
+ (NSUInteger)randomIndexFromRangeSized:(NSUInteger)size;

+ (BOOL)randomChance:(double)chance;
#endif

@end
