// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#if EC_USE_SEN_TEST

#import <SenTestingKit/SenTestingKit.h>

#define ECTestCaseBase SenTestCase

#define ECAssertNotNil	STAssertNotNil
#define ECAssertNil		STAssertNil
#define ECAssertTrue	STAssertTrue
#define ECAssertFalse	STAssertFalse

#else

#import <GHUnit/GHUnit.h>

#define ECTestCaseBase GHTestCase

#define ECAssertNotNil	GHAssertNotNil
#define ECAssertNil		GHAssertNil
#define ECAssertTrue	GHAssertTrue
#define ECAssertFalse	GHAssertFalse

#endif

@interface ECTestCase : ECTestCaseBase
{
	
}

@end
