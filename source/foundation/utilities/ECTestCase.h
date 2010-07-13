// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#if EC_USE_SEN_TEST

#import <SenTestingKit/SenTestingKit.h>

#define ECTestCaseBase SenTestCase

#define ECTestAssertNotNil	STAssertNotNil
#define ECTestAssertNil		STAssertNil
#define ECTestAssertTrue	STAssertTrue
#define ECTestAssertFalse	STAssertFalse
#define ECTestFail			STFail
#define ECTestLog			NSLog

#else

#import <GHUnit/GHUnit.h>

#define ECTestCaseBase GHTestCase

#define ECTestAssertNotNil	GHAssertNotNil
#define ECTestAssertNil		GHAssertNil
#define ECTestAssertTrue	GHAssertTrue
#define ECTestAssertFalse	GHAssertFalse
#define ECTestFail			GHFail
#define ECTestLog			GHTestLog

#endif

@interface ECTestCase : ECTestCaseBase
{
	
}

@end
