// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECErrorReporter.h"
#import "ECLogging.h"
#import "ECAssertion.h"

@interface ECErrorReporter()

// --------------------------------------------------------------------------
// Private Properties
// --------------------------------------------------------------------------


// --------------------------------------------------------------------------
// Private Methods
// --------------------------------------------------------------------------

+ (void)reportError:(NSError*) error format:(NSString*)format arguments:(va_list)arguments assertInDebug:(BOOL)assertInDebug;

@end


@implementation ECErrorReporter

// --------------------------------------------------------------------------
// Channels
// --------------------------------------------------------------------------

ECDefineLogChannel(ErrorChannel);

// --------------------------------------------------------------------------
// Globals
// --------------------------------------------------------------------------


// --------------------------------------------------------------------------
//! Internal helper which builds the message and reports the error.
// --------------------------------------------------------------------------

+ (void)reportError:(NSError*) error format:(NSString*)format arguments:(va_list)arguments assertInDebug:(BOOL)assertInDebug
{
    // compose the message
    NSString* message = [[NSString alloc] initWithFormat:format arguments:arguments];
    if (error)
    {
        ECLog(ErrorChannel, @"%@ %@", message, error);
		#if EC_DEBUG && EC_PLATFORM_MAC
			[[NSApplication sharedApplication] presentError:error];
		#endif
    }
    else
    {
        ECLog(ErrorChannel, message);
    }
    
    if (assertInDebug)
    {
        ECAssertShouldntBeHere();
    }
    
    [message release];
}

// --------------------------------------------------------------------------
//! Check if a status value is noErr, if not, log a generic error.
// --------------------------------------------------------------------------

+ (BOOL)checkStatus:(OSStatus)status
{
	BOOL result = status == noErr;
	if (!result)
	{
		[self reportStatus:status message:@"status wasn't noErr"];
	}
	
	return result;
}

// --------------------------------------------------------------------------
//! Convenience method for global error reporting.
//! Checks the success value first, and reports the error value if the success value was NO
//! Asserts on failure in debug builds.
// --------------------------------------------------------------------------

+ (void)reportResult:(BOOL)didSucceed error:(NSError*) error message:(NSString*)message, ... 
{
    if (!didSucceed) 
	{
        va_list args;
        va_start(args, message);
        [self reportError:error format:message arguments:args assertInDebug:YES];
        va_end(args);
    }
}

// --------------------------------------------------------------------------
//! Convenience method for global error reporting.
//! Checks the success value, and reports a custom error if it was NO
//! Asserts on failure in debug builds.
// --------------------------------------------------------------------------

+ (void)reportResult:(BOOL)didSucceed message:(NSString*)message, ... 
{
    if (!didSucceed) 
	{
        va_list args;
        va_start(args, message);
        [self reportError:nil format:message arguments:args assertInDebug:YES];
        va_end(args);
    }
}

// --------------------------------------------------------------------------
//! Convenience method for global error reporting.
//! Checks the success value, and reports a custom error if it was NO
//! Asserts on failure in debug builds.
// --------------------------------------------------------------------------

+ (void)reportStatus:(OSStatus)status message:(NSString*)message, ...
{
    if (status != noErr) 
	{
        va_list args;
        va_start(args, message);
        [self reportError:nil format:message arguments:args assertInDebug:YES];
        va_end(args);
    }
}

// --------------------------------------------------------------------------
//! Convenience method for global error reporting.
//! Reports the given error, if it's non-nil.
//! Asserts on failure in debug builds.
// --------------------------------------------------------------------------

+ (void)reportError:(NSError*) error message:(NSString*)message, ... 
{
    if (error) 
	{
        va_list args;
        va_start(args, message);
        [self reportError:error format:message arguments:args assertInDebug:YES];
        va_end(args);
    }
}

@end
