// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECLogging.h"

@class ECLogChannel;
@interface ECLogHandler : NSObject 

{
@private
	NSString* name;
}

@property (nonatomic, retain) NSString* name;

- (void)logFromChannel:(ECLogChannel*)channel withObject:(id)object arguments:(va_list)arguments context:(ECLogContext*)context;
- (NSComparisonResult)caseInsensitiveCompare:(ECLogHandler*)other;

@end
