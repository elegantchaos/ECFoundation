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


@interface NSDate_ECUtilitiesTests : ECTestCase
{
	NSDateFormatter*	mFormatter;
	NSDate*				mOrigin;
	NSDate*				mThirtySecondsLater;
	NSDate*				mFiveMinutesLater;
	NSDate*				mSevenHoursLater;
	NSDate*				mTwentyThreeHoursLater;
	NSDate*				mThreeDaysLater;
}

@end
