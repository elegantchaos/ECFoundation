// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
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
	NSTimeInterval interval = date ? [date timeIntervalSinceDate: self] : -[self timeIntervalSinceNow];
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
			[formatter setDateFormat: @"MMMM d"];
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

// --------------------------------------------------------------------------
//! Return a date representing local midnight at the beginning of the given date.
// --------------------------------------------------------------------------

- (NSDate*)startOfDay
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
    NSDate* result = [calendar dateFromComponents:components];
    
    return result;
}

// --------------------------------------------------------------------------
//! Return the relative position of one date from another in terms of days.
//! Is it an earlier day, the same day, or a later day?
//! Ignores time components.
// --------------------------------------------------------------------------

- (DayOffset)dayOffsetFrom:(NSDate*)date
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* myComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
    NSDateComponents* otherComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
    
    DayOffset result;
    
    if (myComponents.year < otherComponents.year)
    {
        result = EarlierDay;
    }
    else if (myComponents.year > otherComponents.year)
    {
        result = LaterDay;
    }
    else
    {
        if (myComponents.month < otherComponents.month)
        {
            result = EarlierDay;
        }
        else if (myComponents.month > otherComponents.month)
        {
            result = LaterDay;
        }
        else
        {
            if (myComponents.day < otherComponents.day)
            {
                result = EarlierDay;
            }
            else if (myComponents.day > otherComponents.day)
            {
                result = LaterDay;
            }
            else 
            {
                result = SameDay;
            }
        }
    }
    
    return result;
}

- (BOOL)isEarlierDayThan:(NSDate*)date
{
    return [self dayOffsetFrom:date] == EarlierDay;
}

- (BOOL)isSameDayAs:(NSDate*)date
{
    return [self dayOffsetFrom:date] == SameDay;
}

- (BOOL)isLaterDayThan:(NSDate*)date
{
    return [self dayOffsetFrom:date] == LaterDay;
}

- (BOOL)isToday
{
    return [self isSameDayAs:[NSDate date]];
}

+ (NSDate*)dateWithTimeIntervalSinceStartOfToday:(NSTimeInterval)interval
{
    NSDate* today = [NSDate date];
    NSDate* result = [today dateByAddingTimeIntervalSinceStartOfDay:interval];
    
    return result;
}

- (NSTimeInterval)timeIntervalSinceStartOfDay
{
    NSDate* startOfDay = [self startOfDay];
    NSTimeInterval result = [self timeIntervalSinceDate:startOfDay];
    
    return result;
}

- (NSDate*)dateByAddingTimeIntervalSinceStartOfDay:(NSTimeInterval)interval
{
    NSDate* startOfDay = [self startOfDay];
    NSDate* result = [startOfDay dateByAddingTimeInterval:interval];
    
    return result;
}

- (NSDate*)dateByChangingTimeToNow
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceStartOfDay];
    NSDate* result = [self dateByAddingTimeIntervalSinceStartOfDay:interval];
    
    return result;
}

@end
