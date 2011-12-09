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

}

#ifdef TO_DO
- (NSArray*)componentsSeparatedByMixedCaps;

- (NSString*)stringBySplittingMixedCaps;

+ (NSString*)stringByFormattingCount:(NSUInteger)count singularFormat:(NSString*)singularFormat pluralFormat:(NSString*)pluralFormat;
+ (NSString*)stringWithMixedCapsFromWords:(NSArray*)words initialCap:(BOOL)initialCap;
+ (NSString*)stringWithUppercaseFromWords:(NSArray*)words separator:(NSString*)separator;
+ (NSString*)stringWithLowercaseFromWords:(NSArray*)words separator:(NSString*)separator;
+ (NSString*)stringWithNewUUID;

- (NSString*)sha1Digest;

+ (NSString*)stringWithOrdinal:(NSInteger)ordinal;

- (NSString*)truncateToLength:(NSUInteger)length;
#endif

@end
