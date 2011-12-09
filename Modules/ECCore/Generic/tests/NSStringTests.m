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

- (void) testSplitWordsIntoInts
{
	NSString* string = [NSString stringWithString: @"1 2 3 4 5 -1 -2 -3 -4 -5"];
	
	NSData* data = [string splitWordsIntoInts];
	
	ECTestAssertTrue([data length] == sizeof(int) * 10);
	
	const int* ints = [data bytes];
	for (int n = 0; n < 10; ++n)
	{
		int expected = (n < 5) ? n + 1 : 4 - n;
		ECTestAssertIsEqual(ints[n], expected);
	}
}

- (void) testSplitWordsIntoFloats
{
	NSString* string = [NSString stringWithString: @"1.1 2.2 3.3 4.4 5.5 -1.1 -2.2 -3.3 -4.4 -5.5"];
	
	NSData* data = [string splitWordsIntoFloats];
	
	ECTestAssertTrue([data length] == sizeof(float) * 10);
	
	const float* floats = [data bytes];
	for (int n = 0; n < 10; ++n)
	{
		float expected = 1.1 * ((n < 5) ? n + 1 : 4 - n);
		ECTestAssertRealIsEqual(floats[n], expected);
	}
}

- (void) testSplitWordsIntoDoubles
{
	NSString* string = [NSString stringWithString: @"1.1 2.2 3.3 4.4 5.5 -1.1 -2.2 -3.3 -4.4 -5.5"];
	
	NSData* data = [string splitWordsIntoDoubles];
	
	ECTestAssertTrue([data length] == sizeof(double) * 10);
	
	const double* doubles = [data bytes];
	for (int n = 0; n < 10; ++n)
	{
		double expected = 1.1 * ((n < 5) ? n + 1 : 4 - n);
		ECTestAssertTrue(fabs(doubles[n] - expected) < 0.000001); // may be some minor rounding errors, so we test approximate equality
	}
}

- (void)testContainsBeginsEnds
{
	ECTestAssertTrue([@"test" containsString:@"test"]);
	ECTestAssertTrue([@"test" containsString:@"est"]);
	ECTestAssertTrue([@"test" containsString:@"tes"]);
	ECTestAssertTrue([@"test" containsString:@"es"]);
	ECTestAssertTrue([@"test" containsString:@"e"]);
	ECTestAssertFalse([@"test" containsString:@""]);
	ECTestAssertFalse([@"test" containsString:@"testa"]);
	ECTestAssertFalse([@"test" containsString:@"atest"]);

	ECTestAssertTrue([@"test" beginsWithString:@"test"]);
	ECTestAssertTrue([@"test" beginsWithString:@"tes"]);
	ECTestAssertTrue([@"test" beginsWithString:@"te"]);
	ECTestAssertTrue([@"test" beginsWithString:@"t"]);
	ECTestAssertFalse([@"test" beginsWithString:@""]);
	ECTestAssertFalse([@"test" beginsWithString:@"est"]);

	ECTestAssertTrue([@"test" endsWithString:@"test"]);
	ECTestAssertTrue([@"test" endsWithString:@"est"]);
	ECTestAssertTrue([@"test" endsWithString:@"st"]);
	ECTestAssertTrue([@"test" endsWithString:@"t"]);
	ECTestAssertFalse([@"test" endsWithString:@""]);
	ECTestAssertFalse([@"test" endsWithString:@"tes"]);

	ECTestAssertFalse([@"" containsString:@"test"]);
	ECTestAssertFalse([@"" containsString:@"e"]);
	ECTestAssertFalse([@"" containsString:@""]);
	ECTestAssertFalse([@"" beginsWithString:@""]);
	ECTestAssertFalse([@"" endsWithString:@""]);
	ECTestAssertFalse([@"" beginsWithString:@"test"]);
	ECTestAssertFalse([@"" endsWithString:@"test"]);
}

- (void)testMixedCaps
{
	NSArray* array = [@"aTestString" componentsSeparatedByMixedCaps];
	ECTestAssertLength(array, 3);
	ECTestAssertStringIsEqual([array objectAtIndex:0], @"a");
	ECTestAssertStringIsEqual([array objectAtIndex:1], @"Test");
	ECTestAssertStringIsEqual([array objectAtIndex:2], @"String");
	
	array = [@"" componentsSeparatedByMixedCaps];
	ECTestAssertIsEmpty(array);
	
	ECTestAssertStringIsEqual([@"aTestString" stringBySplittingMixedCaps], @"a Test String");
	ECTestAssertStringIsEqual([@"" stringBySplittingMixedCaps], @"");
	
	NSArray* words = [NSArray arrayWithObjects:@"a", @"TEST", @"string", nil];
	ECTestAssertStringIsEqual([NSString stringWithMixedCapsFromWords:words initialCap:NO], @"aTestString");
	ECTestAssertStringIsEqual([NSString stringWithMixedCapsFromWords:words initialCap:YES], @"ATestString");
	ECTestAssertStringIsEqual([NSString stringWithUppercaseFromWords:words separator:@"_"], @"A_TEST_STRING");
	ECTestAssertStringIsEqual([NSString stringWithLowercaseFromWords:words separator:@"-"], @"a-test-string");
}

- (void)testCountFormatting
{
	ECTestAssertStringIsEqual([NSString stringByFormattingCount:0 singularFormat:@"s %d" pluralFormat:@"p %d"], @"p 0");
	ECTestAssertStringIsEqual([NSString stringByFormattingCount:1 singularFormat:@"s %d" pluralFormat:@"p %d"], @"s 1");
	ECTestAssertStringIsEqual([NSString stringByFormattingCount:2 singularFormat:@"s %d" pluralFormat:@"p %d"], @"p 2");
}

- (void)testOrdinals
{
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:0], @"0th");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:1], @"1st");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:2], @"2nd");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:3], @"3rd");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:4], @"4th");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:5], @"5th");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:6], @"6th");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:7], @"7th");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:8], @"8th");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:9], @"9th");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:10], @"10th");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:11], @"11th");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:12], @"12th");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:13], @"13th");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:14], @"14th");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:15], @"15th");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:16], @"16th");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:17], @"17th");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:18], @"18th");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:19], @"19th");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:20], @"20th");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:21], @"21st");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:124], @"124th");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:422], @"422nd");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:121], @"121st");
	ECTestAssertStringIsEqual([NSString stringWithOrdinal:1000], @"1000th");
}

- (void)testTruncate
{
	ECTestAssertStringIsEqual([@"Test" truncateToLength:4], @"Test");
	ECTestAssertStringIsEqual([@"Test" truncateToLength:5], @"Test");
	ECTestAssertStringIsEqual([@"Test" truncateToLength:3], @"Te…");
	ECTestAssertStringIsEqual([@"Test" truncateToLength:0], @"");
	ECTestAssertStringIsEqual([@"" truncateToLength:4], @"");
}

#ifdef TO_DO

+ (NSString*)stringWithNewUUID;

- (NSString*)truncateToLength:(NSUInteger)length;
#endif

@end
