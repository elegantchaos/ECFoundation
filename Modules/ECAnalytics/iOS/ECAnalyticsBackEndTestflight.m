// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 15/11/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECAnalyticsBackEndTestflight.h"
#import "ECAnalyticsLogging.h"
#import "ECAnalyticsEvent.h"

#import "TestFlight.h"

@implementation ECAnalyticsBackEndTestFlight

#pragma mark - Object Lifecycle

// --------------------------------------------------------------------------
//! Perform one-time initialisation of the engine.
// --------------------------------------------------------------------------

- (void)startupWithEngine:(ECAnalyticsEngine*)engineIn;
{
    self.engine = engineIn;
    
    NSString* token = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"TestFlightToken"];
    if (token)
    {
        [TestFlight takeOff:token];
    }

}

// --------------------------------------------------------------------------
//! Perform one-time cleanup of the engine.
// --------------------------------------------------------------------------

- (void)shutdown
{
}

// --------------------------------------------------------------------------
//! Log an un-timed event.
// --------------------------------------------------------------------------

- (void)untimedEvent:(NSString*)event forObject:(id)object parameters:(NSDictionary*)parameters
{
    [TestFlight passCheckpoint:event];
}

// --------------------------------------------------------------------------
//! Start logging a timed event. Returns the event, which can be ended by calling logTimedEventEnd:
// --------------------------------------------------------------------------

- (ECAnalyticsEvent*)timedEventStart:(NSString*)eventName forObject:(id)object parameters:(NSDictionary*)parameters
{
	ECAnalyticsEvent* event = [[[ECAnalyticsEvent alloc] initWithName:eventName parameters:parameters] autorelease];
	
	return event;
}

// --------------------------------------------------------------------------
//! Finish logging a timed event.
// --------------------------------------------------------------------------

- (void)timedEventEnd:(ECAnalyticsEvent*)event
{
    [TestFlight passCheckpoint:event.name];
}

// --------------------------------------------------------------------------
//! Log an error.
// --------------------------------------------------------------------------

- (void)error:(NSError*)error message:(NSString*)message
{
    [TestFlight passCheckpoint:[NSString stringWithFormat:@"Error: %@", message]];
}

// --------------------------------------------------------------------------
//! Log an exception.
// --------------------------------------------------------------------------

- (void)exception:(NSException*)exception
{
}

// --------------------------------------------------------------------------
//! Use the TestFlight exception handling.
// --------------------------------------------------------------------------

- (BOOL)hasOwnExceptionHandler
{
    return YES;
}

@end
