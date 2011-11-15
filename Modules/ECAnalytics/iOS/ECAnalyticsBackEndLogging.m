// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 15/11/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------
#import "ECAnalyticsBackEndLogging.h"
#import "ECAnalyticsBackEnd.h"

#import "ECAnalyticsEvent.h"
#import "ECAnalyticsLogging.h"


@implementation ECAnalyticsBackEndLogging

// Perform one-time initialisation of the engine.
- (void)startupWithEngine:(ECAnalyticsEngine*)engineIn;
{
    self.engine = engineIn;
    
	ECDebug(AnalyticsChannel, @"startup logging Analytics engine");
}

// Perform one-time cleanup of the engine.
- (void)shutdown
{
	ECDebug(AnalyticsChannel, @"shutdown logging Analytics engine");
}

// Log an un-timed event.
- (void)untimedEvent:(NSString*)event forObject:(id)object parameters:(NSDictionary*)parameters
{
	ECDebug(AnalyticsChannel, @"logged untimed event %@ with parameters %@", event, parameters);
}

// Start logging a timed event. Returns the event, which can be ended by calling logTimedEventEnd:
- (ECAnalyticsEvent*)timedEventStart:(NSString*)eventName forObject:(id)object parameters:(NSDictionary*)parameters
{
	ECDebug(AnalyticsChannel, @"started timed event %@ with parameters %@", eventName, parameters);
	
	ECAnalyticsEvent* event = [[[ECAnalyticsEvent alloc] initWithName:eventName parameters:parameters] autorelease];
	
	return event;
}

// Finish logging a timed event.
- (void)timedEventEnd:(ECAnalyticsEvent*)event
{
	ECDebug(AnalyticsChannel, @"finished timed event %@ with parameters %@", event.name, event.parameters);
}

// Log an error.
- (void)error:(NSError*)error message:(NSString*)message
{
	ECDebug(AnalyticsChannel, @"logged error %@: %@ ", error, message);
}

// Log an exception.
- (void)exception:(NSException*)exception
{
	ECDebug(AnalyticsChannel, @"logged exception %@", exception);
}

@end
