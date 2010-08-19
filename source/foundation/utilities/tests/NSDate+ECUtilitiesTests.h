// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/07/2010.
//
//! @file:
//! Unit tests for the NSDate+ECUtilitiesTests.h category.
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
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
