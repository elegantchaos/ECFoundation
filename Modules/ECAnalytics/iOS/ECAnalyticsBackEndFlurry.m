// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 15/11/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------
#import "ECAnalyticsBackEndFlurry.h"
#import "ECAnalyticsBackEnd.h"

#import "ECAnalyticsEvent.h"
#import "ECAnalyticsLogging.h"
#import "ECAnalyticsEngine.h"

#import "FlurryAPI.h"

#ifndef FLURRY_LOGGING_ON
    #define FLURRY_LOGGING_ON 0
#endif

#if FLURRY_LOGGING_ON
    #define FlurryLogDetail ECAnalyticsLogDebug
#else
    #define FlurryLogDetail(...)
#endif

static const NSUInteger kMaximumParameters = 10;

@interface ECAnalyticsBackEndFlurry()
@end

@implementation ECAnalyticsBackEndFlurry

@synthesize apiKey;

// Perform one-time initialisation of the engine.
- (void)startupWithEngine:(ECAnalyticsEngine*)engineIn;
{
    self.engine = engineIn;
    
	ECDebug(AnalyticsChannel, @"startup Flurry analytics engine %@", [FlurryAPI getFlurryAgentVersion]);
	
	[FlurryAPI startSession:self.apiKey];
	
	// Make sure Flurry updates as quickly as possible - these should be the default values anyway
	[FlurryAPI setSessionReportsOnCloseEnabled:YES];
	[FlurryAPI setSessionReportsOnPauseEnabled:YES];
	[FlurryAPI setEventLoggingEnabled:YES];
}

// Perform one-time cleanup of the engine.
- (void)shutdown
{
	ECDebug(AnalyticsChannel, @"shutdown Flurry analytics engine");
}

// Log an un-timed event.
- (void)untimedEvent:(NSString*)eventName forObject:(id)object parameters:(NSDictionary*)parametersOrNil
{
	FlurryLogDetail(@"logged untimed event %@ with parameters %@", eventName, parametersOrNil);
    
    if (parametersOrNil)
    {
        [FlurryAPI logEvent:eventName withParameters:parametersOrNil timed:NO];
    }
    else
    {
        [FlurryAPI logEvent:eventName timed:NO];
    }
}

// Start logging a timed event. Returns the event, which can be ended by calling logTimedEventEnd:
- (ECAnalyticsEvent*)timedEventStart:(NSString*)eventName forObject:(id)object parameters:(NSDictionary*)parametersOrNil
{
    
	FlurryLogDetail(@"started timed event %@ with parameters %@", eventName, parametersOrNil);
	
	ECAnalyticsEvent* event = [[[ECAnalyticsEvent alloc] initWithName: eventName parameters: parametersOrNil] autorelease];
    NSAssert([event.parameters count] <= kMaximumParameters, @"Flurry has a limit of %d parameters", kMaximumParameters);
	
	[FlurryAPI logEvent:eventName timed:YES];

	return event;
}

// Finish logging a timed event.
- (void)timedEventEnd:(ECAnalyticsEvent*)event
{
    NSAssert([event.parameters count] <= kMaximumParameters, @"Flurry has a limit of %d parameters", kMaximumParameters);

	FlurryLogDetail(@"ended timed event %@", event.name);

	[FlurryAPI endTimedEvent:event.name withParameters:event.parameters];
}

// Log an error.
- (void)error:(NSError*)error message:(NSString*)message;
{
    FlurryLogDetail(@"Error reported to flurry: %@ %@ %@", name, message, error);
    [FlurryAPI logError:[error domain] message:message error:error];
}
// Log an exception.
- (void)exception:(NSException*)exception
{
    NSDictionary* info = [exception userInfo];
    NSString* compact = [self compactStackFromException:exception];
    NSString* symbolic = [self symbolicStackFromException:exception];

    // We always send the compact crawl since it's most likely to be useful
    NSString* message = compact;
    
    // If we've got extra info parameters, also send them
    // Otherwise, send the symbolic crawl if we have that
    NSString* error = info ? [info description] : (symbolic ? symbolic : @"");

    // Flurry will report the exception's name and reason properties so there's no need to repeat them in our own messages
    FlurryLogDetail(@"Exception reported to flurry: %@", exception);
	[FlurryAPI logError:error message:message exception:exception];
    
    // Also generate an event
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    if (symbolic) {
        [parameters setObject:symbolic forKey: @"Symbolic"]; 
    }
    
    if (compact) {
        [parameters setObject:compact forKey:@"Stack"]; 
    }
    
    [parameters setObject:[NSDate date] forKey:@"Timestamp"];

    if (info && ([info count] < (kMaximumParameters - [parameters count]))) {
        [parameters addEntriesFromDictionary:info]; 
    }
    

    [FlurryAPI logEvent:@"Exception" withParameters:parameters timed:NO];
}

@end
