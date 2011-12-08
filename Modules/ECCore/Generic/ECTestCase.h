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
#define ECTestAssertTrue(x)						ECTestAssertTrueFormat(x, @"%s should be true", #x)
#define ECTestAssertFalse(x)					ECTestAssertFalseFormat(x, @"%s should be false", #x)
#define ECTestAssertIsEqual(x,y)				ECTestAssertTrueFormat((x) == (y), @"%s (%ld) should equal %s (%ld)", #x, x, #y, y)
#define ECTestAssertIsNotEqual(x,y)				ECTestAssertTrueFormat((x) != (y), @"%s (%ld) should not equal %s (%ld)", #x, x, #y, y)
#define ECTestAssertIsEqualString(x,y)			ECTestAssertTrueFormat([(x) isEqualToString:(y)], @"strings %s and %s should match, values were \"%@\" and \"%@\"", #x, #y, x, y)
#define ECTestAssertStringBeginsWith(x,y)		ECTestAssertTrueFormat([x beginsWithString:y], @"string %s should begin with %s, values were \"%@\" and \"%@\"", #x, #y, x, y)
#define ECTestAssertStringEndsWith(x,y)			ECTestAssertTrueFormat([x endsWithString:y], @"string %s should end with %s, values were \"%@\" and \"%@\"", #x, #y, x, y)
#define ECTestAssertStringContains(x,y)			ECTestAssertTrueFormat([x containsString:y], @"string %s should contain %s, values were \"%@\" and \"%@\"", #x, #y, x, y)

#define ECTestFail						STFail
#define ECTestLog						NSLog

@interface ECTestCase : SenTestCase
@end
