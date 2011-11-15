// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 15/11/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECAnalyticsBackEnd.h"

#import "ECAnalyticsEvent.h"
#import "ECAnalyticsLogging.h"
#import "ECAnalyticsEventTarget.h"
#import "ECAnalyticsStandardKeys.h"


#pragma mark - Private Interface

@interface ECAnalyticsBackEnd()
@end

@implementation ECAnalyticsBackEnd

@synthesize engine;

#pragma mark - Lifecycle

- (void)dealloc
{
    [engine release];
    
    [super dealloc];
}

#pragma mark - Engine Implementation Methods

// Perform engine specific startup - to be overriden by implementations.
- (void)startupWithEngine:(ECAnalyticsEngine *)engineIn
{
    self.engine = engineIn;
	ECDebug(AnalyticsChannel, @"subclasses should implement this method");
}

// Perform engine specific shutdown - to be overriden by implementations.
- (void)shutdown
{
	ECDebug(AnalyticsChannel, @"subclasses should implement this method");
}

// Suspend the engine (typically called when the application goes into the background)
- (void)suspend
{
    // by default we just shut down completely on suspend, and restart on resume
    // subclasses should override suspend and resume if they can do something smarter
    [self shutdown];
}

// Resume the engine (typically called when the application returns to the foreground)
- (void)resume
{
    // by default we just shut down completely on suspend, and restart on resume
    // subclasses should override suspend and resume if they can do something smarter
    [self startupWithEngine:self.engine];
}

// Perform logging of untimed event - to be overriden by implementations.
- (void)untimedEvent:(NSString*)event forObject:(id)object parameters:(NSDictionary*)parameters;
{
	ECDebug(AnalyticsChannel, @"subclasses should implement this method");
}

// Create a timed event - to be overriden by implementations.
- (ECAnalyticsEvent*)timedEventStart:(NSString*)event forObject:(id)object parameters:(NSDictionary*)parameters;
{
	ECDebug(AnalyticsChannel, @"subclasses should implement this method");
	
	return nil;
}

// Finish with a timed event - to be overriden by implementations.
- (void)timedEventEnd:(ECAnalyticsEvent*)event
{
	ECDebug(AnalyticsChannel, @"subclasses should implement this method");
}

// Perform error logging - to be overriden by implementations.
- (void)error:(NSError*)error message:(NSString*)message;
{
	ECDebug(AnalyticsChannel, @"subclasses should implement this method");
}

// Perform exception logging - to be overriden by implementations.
- (void)exception:(NSException*)exception
{
	ECDebug(AnalyticsChannel, @"subclasses should implement this method");
}

#pragma mark - Exception Utilities


- (BOOL)hasOwnExceptionHandler
{
    return NO;
}



@end
