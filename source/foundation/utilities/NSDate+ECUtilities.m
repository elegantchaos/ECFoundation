// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 19/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "NSDate+ECUtilities.h"

static const NSTimeInterval kMinute = 60;
static const NSTimeInterval kHour = 60 * 60;
static const NSTimeInterval kMaxHours = 60 * 60 * 8;
static const NSTimeInterval kDay = 60 * 60 * 24;

@implementation NSDate(ECUtilities)

// --------------------------------------------------------------------------
//! Return a textual description of a time interval.
//!
//! The interval is described as if it's in the past,
//! e.g. "12 minutes ago".
//!
//! If it's more than 8 hours ago, we return nil, so that the
//! caller can use some other kind of description.
// --------------------------------------------------------------------------

+ (NSString *) formattedRelativeToInterval: (NSTimeInterval) interval
{
	NSString* result;
	
	if (interval < 0)
	{
		result = @"In the future";
	}
	else if (interval < kMinute)
	{
		result = @"Less than a minute ago";
	}
	else if (interval < kHour)
	{
		result = [NSString stringWithFormat: @"%d minutes ago", (NSUInteger) (interval / kMinute)];
	}
	else if (interval < kMaxHours)
	{
		result = [NSString stringWithFormat: @"%d hours ago", (NSUInteger) (interval / kHour)];
	}
	else
	{
		result = nil;
	}
	
	return result;
}

// --------------------------------------------------------------------------
//! Return a textual description of a time relative to this one.
//!
//! If it's more than 8 hours ago, we return nil, so that the
//! caller can use some other kind of description.
// --------------------------------------------------------------------------

- (NSString *) formattedRelativeTo: (NSDate*) date
{
	NSTimeInterval interval = [date timeIntervalSinceDate: self];
	return [NSDate formattedRelativeToInterval: interval];
}

// --------------------------------------------------------------------------
//! Return a textual description of a this time relative to the current
//! time.
//!
//! If it's more than 8 hours ago, we return nil, so that the
//! caller can use some other kind of description.
// --------------------------------------------------------------------------

- (NSString*) formattedRelative;
{
	NSTimeInterval interval = -[self timeIntervalSinceNow];
	return [NSDate formattedRelativeToInterval: interval];
}

// --------------------------------------------------------------------------
//! Return a textual description of a time relative to this one.
//! If the time interval is large, we use days or weeks.
//! If it gets even larger we use the actual month, or the actual year.
// --------------------------------------------------------------------------

- (NSString*) formattedRelativeWithDayTo: (NSDate*) date;
{
	NSString* result = [self formattedRelativeTo: date];
	if (result == nil)
	{
		NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"yyyy-MM-dd"];
		
		NSDate* midnight = [formatter dateFromString:[formatter stringFromDate:self]];
		NSTimeInterval interval = (date) ? [midnight timeIntervalSinceDate: date] : [midnight timeIntervalSinceNow];
		NSUInteger dayDiff = ((NSInteger) -interval) / (60*60*24);
		
		if (dayDiff == 0)
		{
			result = @"Today";
		} 
		else if (dayDiff == 1)
		{
			result = @"Yesterday";
		}
		else if (dayDiff < 8)
		{
			result = [NSString stringWithFormat: @"%d days ago", dayDiff];
		}
		else if (dayDiff < 365)
		{
			[formatter setDateFormat: @"MMMM"];
			result = [formatter stringFromDate:self];
		}
		else
		{
			[formatter setDateFormat: @"yyyy"];
			result = [formatter stringFromDate:self];
		}
		
		[formatter release];
	}
	
	return result;
}

// --------------------------------------------------------------------------
//! Return a textual description of a time relative to now.
//! If the time interval is large, we use days or weeks.
//! If it gets even larger we use the actual month, or the actual year.
// --------------------------------------------------------------------------

- (NSString*) formattedRelativeWithDay;
{
	return [self formattedRelativeWithDayTo: nil];
}

@end
