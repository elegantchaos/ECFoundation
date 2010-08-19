// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 19/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "NSDate+ECUtilities.h"

static const NSTimeInterval kMinute = 60;
static const NSTimeInterval kHour = 60 * 60;
static const NSTimeInterval kDay = 60 * 60 * 24;

@implementation NSDate(ECUtilities)

- (NSString*) formattedRelative;
{
	NSTimeInterval interval = -[self timeIntervalSinceNow];
	NSString* result;
	
	if (interval < kMinute)
	{
		result = @"Less than a minute ago";
	}
	else if (interval < kHour)
	{
		result = [NSString stringWithFormat: @"%d minutes ago", (NSUInteger) (interval / kMinute)];
	}
	else if (interval < kDay)
	{
		result = [NSString stringWithFormat: @"%d hours ago", (NSUInteger) (interval / kHour)];
	}
	else
	{
		result = [self formattedRelativeWithDay];
	}
	
	return result;
}

- (NSString*) formattedRelativeWithDay;
{
	NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	
	NSDate* midnight = [formatter dateFromString:[formatter stringFromDate:self]];
	NSUInteger dayDiff = (int)[midnight timeIntervalSinceNow] / (60*60*24);
	
	switch(dayDiff) 
	{
		case 0:
			[formatter setDateFormat:@"'Today, 'X"]; break;
		case -1:
			[formatter setDateFormat:@"'Yesterday, 'X"]; break;
		default:
			[formatter setDateFormat:@"MMMM d, X"];
	}
	
	NSString* result = [formatter stringFromDate:self];
	[formatter release];
	
	return result;
}
@end
