// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECLogHandler.h"
#import "ECAssertion.h"
#import "ECLogChannel.h"
#import "ECLogging.h"

@implementation ECLogHandler

#pragma mark - Properties

@synthesize name;

#pragma mark - Lifecycle

// --------------------------------------------------------------------------
//! Clean up.
// --------------------------------------------------------------------------

- (void)dealloc 
{
    [name release];
    
    [super dealloc];
}

#pragma mark - Logging

// --------------------------------------------------------------------------
//! Log.
// --------------------------------------------------------------------------


- (void)logFromChannel:(ECLogChannel*)channel withObject:(id)object arguments:(va_list)arguments context:(ECLogContext*)context
{
	ECAssertShouldntBeHere();
}

#pragma mark - Sorting

// --------------------------------------------------------------------------
//! Comparison function for sorting alphabetically by name.
// --------------------------------------------------------------------------

- (NSComparisonResult)caseInsensitiveCompare:(ECLogHandler*)other
{
	return [self.name caseInsensitiveCompare: other.name];
}

// --------------------------------------------------------------------------
//! Utility for simple log handlers that just output a string.
//! Converts the input parameters into a string to log.
// --------------------------------------------------------------------------

- (NSString*)simpleOutputStringForChannel:(ECLogChannel*)channel withObject:(id)object arguments:(va_list)arguments context:(ECLogContext*)context
{
    NSString* result;
    
    if (![channel showContext:ECLogContextMessage])
    {
        // just log the context
        result = [channel stringFromContext:context];
    }
    else
    {
        // log the message, possibly with a context appended
        if ([object isKindOfClass:[NSString class]])
        {
            NSString* format = object;
            result = [[[NSString alloc] initWithFormat:format arguments: arguments] autorelease];
        }
        else
        {
            result = [object description];
        }
        
        NSString* contextString = [channel stringFromContext:context];
        if ([contextString length])
        {
            result = [NSString stringWithFormat:@"%@ «%@»", result, contextString];
        }
    }
    
    return result;
}

@end
