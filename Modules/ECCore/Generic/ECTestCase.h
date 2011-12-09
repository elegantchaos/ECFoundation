// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <SenTestingKit/SenTestingKit.h>

#define ECTestAssertNotNilFormat				STAssertNotNil
#define ECTestAssertNilFormat					STAssertNil
#define ECTestAssertTrueFormat					STAssertTrue
#define ECTestAssertFalseFormat					STAssertFalse

#define ECTestAssertNotNil(x)					ECTestAssertNotNilFormat((x), @"%s shouldn't be nil", #x)
#define ECTestAssertNil(x)						ECTestAssertNilFormat(x, @"%s should be nil, was %0x", #x, x)
#define ECTestAssertZero(x)						ECTestAssertTrueFormat(x == 0, @"%s should be zero, was %0x", #x, x)
#define ECTestAssertTrue(x)						ECTestAssertTrueFormat(x, @"%s should be true", #x)
#define ECTestAssertFalse(x)					ECTestAssertFalseFormat(x, @"%s should be false", #x)
#define ECTestAssertStringIsEqual(x,y)			ECTestAssertTrueFormat([(x) isEqualToString:(y)], @"strings %s and %s should match, values were \"%@\" and \"%@\"", #x, #y, x, y)
#define ECTestAssertStringBeginsWith(x,y)		ECTestAssertTrueFormat([x beginsWithString:y], @"string %s should begin with %s, values were \"%@\" and \"%@\"", #x, #y, x, y)
#define ECTestAssertStringEndsWith(x,y)			ECTestAssertTrueFormat([x endsWithString:y], @"string %s should end with %s, values were \"%@\" and \"%@\"", #x, #y, x, y)
#define ECTestAssertStringContains(x,y)			ECTestAssertTrueFormat([x containsString:y], @"string %s should contain %s, values were \"%@\" and \"%@\"", #x, #y, x, y)
#define ECTestAssertIsEmpty(x)					ECTestAssertTrueFormat([ECTestCase genericCount:x] == 0, @"%s should be empty, value is %@", #x, x)
#define ECTestAssertNotEmpty(x)					ECTestAssertTrueFormat([ECTestCase genericCount:x] != 0, @"%s should not be empty, value is %@", #x, x)

#define ECTestAssertTest(x,t,y,f)				ECTestAssertTrueFormat((x) t (y), @"%s should %s %s (values are " f " and " f ")", #x, #t, #y, x, y)

#define ECTestAssertIsEqual(x,y)				ECTestAssertTest(x, ==, y, "%ld")
#define ECTestAssertIsNotEqual(x,y)				ECTestAssertTest(x, !=, y, "%ld")
#define ECTestAssertIsGreater(x,y)				ECTestAssertTest(x, >, y, "%ld")
#define ECTestAssertIsGreaterEqual(x,y)			ECTestAssertTest(x, >=, y, "%ld")
#define ECTestAssertIsLess(x,y)					ECTestAssertTest(x, <, y, "%ld")
#define ECTestAssertIsLessEqual(x,y)			ECTestAssertTest(x, <=, y, "%ld")

#define ECTestAssertRealIsEqual(x,y)			ECTestAssertTest(x, ==, y, "%lf")
#define ECTestAssertRealIsNotEqual(x,y)			ECTestAssertTest(x, !=, y, "%lf")
#define ECTestAssertRealIsGreater(x,y)			ECTestAssertTest(x, >, y, "%lf")
#define ECTestAssertRealIsGreaterEqual(x,y)		ECTestAssertTest(x, >=, y, "%lf")
#define ECTestAssertRealIsLess(x,y)				ECTestAssertTest(x, <, y, "%lf")
#define ECTestAssertRealIsLessEqual(x,y)		ECTestAssertTest(x, <=, y, "%lf")


#define ECTestFail						STFail
#define ECTestLog						NSLog

@interface ECTestCase : SenTestCase

+ (NSUInteger)genericCount:(id)item;

- (NSBundle*)testBundle;
- (NSURL*)testBundleURL;
- (NSString*)testBundlePath;

@end
