// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/07/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
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

typedef ECTestCaseBase ECTestCase;
