// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------



@interface NSDate(ECCore)

typedef enum {
    EarlierDay = -1,
    SameDay = 0,
    LaterDay = 1
} DayOffset;

+ (NSDate*)dateWithTimeIntervalSinceStartOfToday:(NSTimeInterval)interval;

+ (NSString *) formattedRelativeToInterval: (NSTimeInterval) interval;

- (NSString *) formattedRelativeTo: (NSDate*) date;
- (NSString *) formattedRelative;

- (NSString*) formattedRelativeWithDayTo: (NSDate*) date;
- (NSString *) formattedRelativeWithDay;

- (DayOffset)dayOffsetFrom:(NSDate*)date;
- (BOOL)isEarlierDayThan:(NSDate*)date;
- (BOOL)isSameDayAs:(NSDate*)date;
- (BOOL)isLaterDayThan:(NSDate*)date;
- (BOOL)isToday;

- (NSDate*)startOfDay;
- (NSTimeInterval)timeIntervalSinceStartOfDay;
- (NSDate*)dateByAddingTimeIntervalSinceStartOfDay:(NSTimeInterval)interval;
- (NSDate*)dateByChangingTimeToNow;

@end
