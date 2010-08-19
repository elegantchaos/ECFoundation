// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 19/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------



@interface NSDate(ECUtilities)

+ (NSString *) formattedRelativeToInterval: (NSTimeInterval) interval;

- (NSString *) formattedRelativeTo: (NSDate*) date;
- (NSString *) formattedRelative;

- (NSString*) formattedRelativeWithDayTo: (NSDate*) date;
- (NSString *) formattedRelativeWithDay;

@end
