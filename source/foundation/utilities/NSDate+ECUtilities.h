// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 19/08/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------



@interface NSDate(ECUtilities)

+ (NSString *) formattedRelativeToInterval: (NSTimeInterval) interval;

- (NSString *) formattedRelativeTo: (NSDate*) date;
- (NSString *) formattedRelative;

- (NSString*) formattedRelativeWithDayTo: (NSDate*) date;
- (NSString *) formattedRelativeWithDay;

@end
