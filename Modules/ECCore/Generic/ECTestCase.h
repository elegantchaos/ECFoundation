// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <SenTestingKit/SenTestingKit.h>
#import "NSString+ECCore.h"

#define ECAssertTest(expr, isTrueVal, expString, description, ...) \
do { \
BOOL _evaluatedExpression = (expr);\
if (!_evaluatedExpression) {\
[self failWithException:([NSException failureInCondition:expString \
isTrue:isTrueVal \
inFile:[NSString stringWithUTF8String:__FILE__] \
atLine:__LINE__ \
withDescription:@"%@", STComposeString(description, ##__VA_ARGS__)])]; \
} \
} while (0)

#define ECTestAssertNotNilFormat				STAssertNotNil
#define ECTestAssertNilFormat					STAssertNil
#define ECTestAssertTrueFormat					STAssertTrue
#define ECTestAssertFalseFormat					STAssertFalse

#define ECTestAssertNotNil(x)					ECTestAssertNotNilFormat((x), @"%s shouldn't be nil", #x)
#define ECTestAssertNil(x)						ECTestAssertNilFormat(x, @"%s should be nil, was %0x", #x, x)
#define ECTestAssertZero(x)						ECTestAssertTrueFormat(x == 0, @"%s should be zero, was %0x", #x, x)
#define ECTestAssertTrue(x)						ECTestAssertTrueFormat(x, @"%s should be true", #x)
#define ECTestAssertFalse(x)					ECTestAssertFalseFormat(x, @"%s should be false", #x)
#define ECTestAssertStringIsEqual(x,y)			ECAssertTest([(x) isEqualToString:(y)], NO, @"" #x " and " #y " match", @"Values were \"%@\" and \"%@\"", x, y)
#define ECTestAssertStringBeginsWith(x,y)		ECAssertTest([x beginsWithString:y], NO, @"" #x " begins with " #y, @"Values were \"%@\" and \"%@\"", x, y)
#define ECTestAssertStringEndsWith(x,y)			ECAssertTest([x endsWithString:y], NO, @"" #x " ends with " #y, @"Values were \"%@\" and \"%@\"", x, y)
#define ECTestAssertStringContains(x,y)			ECAssertTest([x containsString:y], NO, @"" #x " contains " #y, @"Values were \"%@\" and \"%@\"", x, y)
#define ECTestAssertIsEmpty(x)					ECAssertTest([ECTestCase genericCount:x] == 0, NO, @"Object" #x "is empty", @"Value is %@", x)
#define ECTestAssertNotEmpty(x)					ECAssertTest([ECTestCase genericCount:x] != 0, YES, @"Object" #x "is empty", @"Value is %@", x)
#define ECTestAssertLength(x, l)				ECAssertTest([ECTestCase genericCount:x] == l, NO, @"Length of " #x " is " #l, @"Value is %@, length is %d", x, [ECTestCase genericCount:x])

#define ECTestAssertOperator(x,t,y,f)			ECAssertTest((x) t (y), NO, @"" #x #t #y, @"Values are " f " and " f ")", x, y)

#define ECTestAssertIntegerIsEqual(x,y)			ECTestAssertOperator(x, ==, y, "%ld")
#define ECTestAssertIntegerIsNotEqual(x,y)		ECTestAssertOperator(x, !=, y, "%ld")
#define ECTestAssertIntegerIsGreater(x,y)		ECTestAssertOperator(x, >, y, "%ld")
#define ECTestAssertIntegerIsGreaterEqual(x,y)	ECTestAssertOperator(x, >=, y, "%ld")
#define ECTestAssertIntegerIsLess(x,y)			ECTestAssertOperator(x, <, y, "%ld")
#define ECTestAssertIntegerIsLessEqual(x,y)		ECTestAssertOperator(x, <=, y, "%ld")

#define ECTestAssertRealIsEqual(x,y)			ECTestAssertOperator(x, ==, y, "%lf")
#define ECTestAssertRealIsNotEqual(x,y)			ECTestAssertOperator(x, !=, y, "%lf")
#define ECTestAssertRealIsGreater(x,y)			ECTestAssertOperator(x, >, y, "%lf")
#define ECTestAssertRealIsGreaterEqual(x,y)		ECTestAssertOperator(x, >=, y, "%lf")
#define ECTestAssertRealIsLess(x,y)				ECTestAssertOperator(x, <, y, "%lf")
#define ECTestAssertRealIsLessEqual(x,y)		ECTestAssertOperator(x, <=, y, "%lf")


#define ECTestFail						STFail
#define ECTestLog						NSLog

@interface ECTestCase : SenTestCase

+ (NSUInteger)genericCount:(id)item;

- (NSBundle*)testBundle;
- (NSURL*)testBundleURL;
- (NSString*)testBundlePath;

@end
