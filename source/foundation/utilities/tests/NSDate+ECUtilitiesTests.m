// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/07/2010.
//
//! @file:
//! Unit tests for the NSDate+ECUtilitiesTests.h category.
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "NSDate+ECUtilitiesTests.h"
#import "NSDate+ECUtilities.h"

@implementation NSDate_ECUtilitiesTests

// --------------------------------------------------------------------------
//! Set up before each test.
// --------------------------------------------------------------------------

- (void) setUp
{
	mFormatter = [[NSDateFormatter alloc] init];
	[mFormatter setDateFormat:@"dd/MM/yyyy HH.mm.ss"];
	
	mOrigin					= [[mFormatter dateFromString: @"12/11/1969 12.00.00"] retain];
	mThirtySecondsLater		= [[mFormatter dateFromString: @"12/11/1969 12.00.30"] retain]; 
	mFiveMinutesLater		= [[mFormatter dateFromString: @"12/11/1969 12.05.30"] retain]; 
	mTwentyThreeHoursLater	= [[mFormatter dateFromString: @"13/11/1969 11.59.30"] retain];
	mThreeDaysLater			= [[mFormatter dateFromString: @"15/11/1969 12.05.00"] retain];

}

// --------------------------------------------------------------------------
//! Tear down after each test.
// --------------------------------------------------------------------------

- (void) tearDown
{
	[mFormatter release];
	[mOrigin release];
	[mThirtySecondsLater release];	
	[mFiveMinutesLater release];
	[mTwentyThreeHoursLater release];
	[mThreeDaysLater release];
}

// --------------------------------------------------------------------------
//! Test NSDictionary valueForKey: intoBool:
// --------------------------------------------------------------------------

- (void) testFormattedRelative
{
	NSString* formatted = [mOrigin formattedRelativeTo: mThirtySecondsLater];
	ECTestAssertTrue([formatted isEqualToString: @"Less than a minute ago"], @"less than a minute should say so, string was %@", formatted);

	formatted = [mOrigin formattedRelativeTo: mFiveMinutesLater];
	ECTestAssertTrue([formatted isEqualToString: @"5 minutes ago"], @"less than an hour should say number of minutes, string was %@", formatted);

	formatted = [mOrigin formattedRelativeTo: mTwentyThreeHoursLater];
	ECTestAssertTrue([formatted isEqualToString: @"23 hours ago"], @"less than 24 hours ago should say number of hours, string was %@", formatted);

	formatted = [mOrigin formattedRelativeTo: mThreeDaysLater];
	ECTestAssertTrue(formatted == nil, @"over 24 hours ago should return nil, string was %@", formatted);
}

@end
