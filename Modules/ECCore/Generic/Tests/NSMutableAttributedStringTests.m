// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTestCase.h"
#import "NSMutableAttributedString+ECCore.h"

@interface NSMutableAttributedStringTests : ECTestCase

@end

@implementation NSMutableAttributedStringTests

- (void)testEdgeCases
{
	NSMutableAttributedString* test = [[NSMutableAttributedString alloc] initWithString:@""];
	ECTestAssertNotNil(test);
	
	NSRegularExpressionOptions options = NSRegularExpressionCaseInsensitive;
	NSError* error = nil;
	NSRegularExpression* expression = [[NSRegularExpression alloc] initWithPattern:@"." options:options error:&error];
	ECTestAssertNotNil(expression);
	
	NSUInteger __block count = 0;
	
	[test matchExpression:expression options:options reversed:NO action:^(NSAttributedString* original, NSMutableAttributedString* current, NSTextCheckingResult* match) { ++count; } ];
	ECTestAssertZero(count);

	[test matchExpression:nil options:options reversed:NO action:^(NSAttributedString* original, NSMutableAttributedString* current, NSTextCheckingResult* match) { ++count; } ];
	ECTestAssertZero(count);

	[test release];
	
}

- (void)testMatchForwards
{
	NSMutableAttributedString* test = [[NSMutableAttributedString alloc] initWithString:@"test test test"];
	ECTestAssertNotNil(test);
	
	NSRegularExpressionOptions options = NSRegularExpressionCaseInsensitive;
	NSError* error = nil;
	NSRegularExpression* expression = [[NSRegularExpression alloc] initWithPattern:@"t..t" options:options error:&error];
	ECTestAssertNotNil(expression);
	
	NSUInteger __block count = 0;
	
	// because we're going forward, we need to replace the string with one of the same length, otherwise the ranges will be messed up
	[test matchExpression:expression options:options reversed:NO action:
	 ^(NSAttributedString* original, NSMutableAttributedString* current, NSTextCheckingResult* match) 
	 {
		 ++count;
		 NSAttributedString* replacement = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"tes%d",count]];
		 [current replaceCharactersInRange:match.range withAttributedString:replacement];
		 [replacement release];
	 }
	 ];

	NSString* string = [test string];
	ECTestAssertIsEqual(count, 3);
	ECTestAssertStringIsEqual(string, @"tes1 tes2 tes3");
	[test release];
}

- (void)testMatchReversed
{
	NSMutableAttributedString* test = [[NSMutableAttributedString alloc] initWithString:@"test test test"];
	ECTestAssertNotNil(test);
	
	NSRegularExpressionOptions options = NSRegularExpressionCaseInsensitive;
	NSError* error = nil;
	NSRegularExpression* expression = [[NSRegularExpression alloc] initWithPattern:@"t..t" options:options error:&error];
	ECTestAssertNotNil(expression);
	
	NSUInteger __block count = 0;

	// as we're going backward, we can safely replace items with longer or shorter strings
	[test matchExpression:expression options:options reversed:YES action:
	 ^(NSAttributedString* original, NSMutableAttributedString* current, NSTextCheckingResult* match) 
	 {
		 ++count;
		 NSAttributedString* replacement = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"test%d",count]];
		 [current replaceCharactersInRange:match.range withAttributedString:replacement];
		 [replacement release];
	 }
	 ];
	
	NSString* string = [test string];
	ECTestAssertIsEqual(count, 3);
	ECTestAssertStringIsEqual(string, @"test3 test2 test1");
	[test release];
}

@end
