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

#import "NSDate+ECCoreTests.h"
#import "NSDate+ECCore.h"

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
	mSevenHoursLater		= [[mFormatter dateFromString: @"12/11/1969 19.10.45"] retain];
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
	[mSevenHoursLater release];
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

	formatted = [mOrigin formattedRelativeTo: mSevenHoursLater];
	ECTestAssertTrue([formatted isEqualToString: @"7 hours ago"], @"less than 8 hours ago should say number of hours, string was %@", formatted);

	formatted = [mOrigin formattedRelativeTo: mTwentyThreeHoursLater];
	ECTestAssertTrue(formatted == nil, @"over 8 hours ago should return nil, string was %@", formatted);
}

// --------------------------------------------------------------------------
//! Test NSDictionary valueForKey: intoBool:
// --------------------------------------------------------------------------

- (void) testFormattedRelativeWithDay
{
	NSString* formatted = [mOrigin formattedRelativeWithDayTo: mThirtySecondsLater];
	ECTestAssertTrue([formatted isEqualToString: @"Less than a minute ago"], @"less than a minute should say so, string was %@", formatted);
	
	formatted = [mOrigin formattedRelativeWithDayTo: mFiveMinutesLater];
	ECTestAssertTrue([formatted isEqualToString: @"5 minutes ago"], @"less than an hour should say number of minutes, string was %@", formatted);
	
	formatted = [mOrigin formattedRelativeWithDayTo: mSevenHoursLater];
	ECTestAssertTrue([formatted isEqualToString: @"7 hours ago"], @"less than 8 hours ago should say number of hours, string was %@", formatted);

	formatted = [mOrigin formattedRelativeWithDayTo: mTwentyThreeHoursLater];
	ECTestAssertTrue([formatted isEqualToString: @"Yesterday"], @"over 8 hours ago should return Today or Yesterday, string was %@", formatted);

	formatted = [mOrigin formattedRelativeWithDayTo: [mFormatter dateFromString: @"12/11/1969 23.59.45"]];
	ECTestAssertTrue([formatted isEqualToString: @"Today"], @"over 8 hours - should return Today, string was %@", formatted);

	formatted = [mOrigin formattedRelativeWithDayTo: mTwentyThreeHoursLater];
	ECTestAssertTrue([formatted isEqualToString: @"Yesterday"], @"over 8 hours - should return Yesterday, string was %@", formatted);

	formatted = [mOrigin formattedRelativeWithDayTo: mThreeDaysLater];
	ECTestAssertTrue([formatted isEqualToString: @"3 days ago"], @"more than 2 days - should return 3 days, string was %@", formatted);

	formatted = [mOrigin formattedRelativeWithDayTo: [mFormatter dateFromString: @"12/01/1970 23.59.45"]];
	ECTestAssertTrue([formatted isEqualToString: @"November 12"], @"more than a month - should return the month and day, string was %@", formatted);

	formatted = [mOrigin formattedRelativeWithDayTo: [mFormatter dateFromString: @"12/01/1971 23.59.45"]];
	ECTestAssertTrue([formatted isEqualToString: @"1969"], @"more than a year - should return the year, string was %@", formatted);

}

// --------------------------------------------------------------------------
//! Test NSDictionary valueForKey: intoBool:
// --------------------------------------------------------------------------

- (void) testDayEdgeCases
{
	NSString* formatted = [mOrigin formattedRelativeWithDayTo: [mFormatter dateFromString: @"12/11/1969 23.59.59"]];
	ECTestAssertTrue([formatted isEqualToString: @"Today"], @"should be today, string was %@", formatted);

	formatted = [mOrigin formattedRelativeWithDayTo: [mFormatter dateFromString: @"13/11/1969 00.00.00"]];
	ECTestAssertTrue([formatted isEqualToString: @"Yesterday"], @"should be yesterday, string was %@", formatted);

	formatted = [mOrigin formattedRelativeWithDayTo: [mFormatter dateFromString: @"13/11/1969 23.59.59"]];
	ECTestAssertTrue([formatted isEqualToString: @"Yesterday"], @"should be yesterday, string was %@", formatted);

	formatted = [mOrigin formattedRelativeWithDayTo: [mFormatter dateFromString: @"14/11/1969 00.00.00"]];
	ECTestAssertTrue([formatted isEqualToString: @"2 days ago"], @"should be 2 days ago, string was %@", formatted);
}

@end
