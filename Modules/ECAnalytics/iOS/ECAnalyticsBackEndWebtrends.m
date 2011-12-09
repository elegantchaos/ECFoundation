// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 15/11/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECAnalyticsBackEndWebtrends.h"
#import "ECAnalyticsEngine.h"
#import "ECAnalyticsStandardKeys.h"
#import "ECAnalyticsEvent.h"
#import "ECAnalyticsLogging.h"

#import <Webtrends/Webtrends.h>

@interface ECAnalyticsBackEndWebtrends()
- (void)sendEventToWebtrends:(WTEvent*)event;
- (void)addDictionary:(NSDictionary*)dictionary toEvent:(WTEvent*)event;
- (NSString*)removeStringValueForKey:(NSString*)key fromDictionary:(NSMutableDictionary*)dictionary orDefault:(NSString*)defaultValue;
@end

@implementation ECAnalyticsBackEndWebtrends

// Take a string value out of the dictionary and return it.
// If the value is nil, or the empty string, we return the given default value instead.
- (NSString*)removeStringValueForKey:(NSString*)key fromDictionary:(NSMutableDictionary*)dictionary orDefault:(NSString*)defaultValue
{
    NSString* result;
    
    // if the dictionary contains a value, make sure it's a string by calling description on it
    NSObject* value = [dictionary objectForKey:key];
    if (value)
    {
        [dictionary removeObjectForKey:key];
        result = [value description];
        
        // the key was the empty string, so use the default value
        if (result.length == 0)
        {
            result = defaultValue;
            ECDebug(AnalyticsChannel, @"parameter for key %@ was empty, using default '%@' instead", key, defaultValue)
        }
    }
    else
    {
        // the key is missing, so use the default value
        result = defaultValue;
        if (defaultValue)
        {
            ECDebug(AnalyticsChannel, @"parameter for key %@ was missing, using default '%@' instead", key, defaultValue)
        }
    }
    
    return result;
}

// Dispatch an event to Webtrends
- (void)sendEventToWebtrends:(WTEvent*)event {
    event.DCSDebug = self.engine.debugLevel > DebugOutputOff;
    event.DCSVerbose = self.engine.debugLevel == DebugOutputVerbose;
    
    @try {
        [self trackEvent:event];
    }
    @catch (NSException *exception) {
        NSLog(@"error sending Webtrends event");
    }
}

// Append all dictionary items to a WTEvent as custom parameters
// We call description on each parameter to make sure it's a string
- (void)addDictionary:(NSDictionary*)dictionary toEvent:(WTEvent*)event
{
    if (dictionary)
    {
        for (NSString* key in [dictionary allKeys])
        {
            [event setValue:[[dictionary objectForKey:key] description] forCustomParameter:key];
        }
    }
}

// Perform one-time initialisation of the engine.
- (void)startupWithEngine:(ECAnalyticsEngine*)engineIn;
{
    self.engine = engineIn;
    
    [WTEvent enableEventTracking];
    
    WTEvent* event = [WTEvent eventForAppLaunch: WTLaunchStyleFromHomeScreen];
    [self sendEventToWebtrends: event];
}

// Perform one-time cleanup of the engine.
- (void)shutdown
{
    WTEvent* event = [WTEvent eventForAppExit];
    [self sendEventToWebtrends: event];
    
    [self disableEventTracking];
}

// Suspend the engine (typically called when the application goes into the background)
- (void)suspend
{
    [self disableEventTracking];
}

// Resume the engine (typically called when the application returns to the foreground)
- (void)resume
{
    [WTEvent enableEventTracking];
}

// Create a WebTrends event
// If the event name is one of our standard constants, we try to use one of the webtrends factory methods
// to construct the event. Otherwise we use the generic init method and pass the event name as the WT eventType parameter.
// We attempt to extract various standard engine parameters and use them to supply values which WT expects us to provide.
- (WTEvent*)makeEventWithName:(NSString*)eventName forObject:(id)object parameters:(NSDictionary*)parameters {
    NSMutableDictionary* mutable = [parameters mutableCopy];
    
    // extract the WT path (dcsuri) parameter
    NSString* path = [self removeStringValueForKey:ECAnalyticsPathParameter fromDictionary:mutable orDefault:@"/unknown/path"];
    
    // extract the WT description (WT.ti) parameter
    NSString* description = [self removeStringValueForKey:ECAnalyticsNameParameter fromDictionary:mutable orDefault:@"unknown description"];
    
    // extract the WT content group (WT.cg_n) parameter
    NSString* group = [self removeStringValueForKey:ECAnalyticsSectionParameter fromDictionary:mutable orDefault:nil];
    
    // extract the WT content subgroup (WT.cg_s) parameter
    NSString* subgroup = [self removeStringValueForKey:ECAnalyticsSubsectionParameter fromDictionary:mutable orDefault:nil];
    if (subgroup) {
        [mutable setObject:subgroup forKey: @"WT.cg_s"];
    }
    
    // create the event
    WTEvent* event = nil;
    if ([eventName isEqualToString:ECAnalyticsViewEvent]) {
        event = [WTEvent eventForContentView:path eventDescr:description eventType:eventName contentGroup:group];
    }
    else if ([eventName isEqualToString:ECAnalyticsMediaEvent]) {
        
        NSString* mediaType = [self removeStringValueForKey:ECAnalyticsTypeParameter fromDictionary:mutable orDefault:@"unknown media type"];
        NSString* mediaName = [self removeStringValueForKey:ECAnalyticsIDParameter fromDictionary:mutable orDefault:@"unknown media name"];
        NSString* mediaEvent = [self removeStringValueForKey:ECAnalyticsMediaEventParameter fromDictionary:mutable orDefault:@"unknown media event"];
        
        event = [WTEvent eventForMediaView:path eventDescr:description eventType:eventName contentGroup:group mediaName:mediaName mediaType:mediaType mediaEvent:mediaEvent];
    }
    else {
        event = [[[WTEvent alloc] initWithEventPath:path eventDescr:description eventType:eventName] autorelease];
    }
    
    // copy remaining parameters from the mutable array into the WT event 
    // we call description on each one first, to ensure that the parameters are all strings
    for (NSString* key in [mutable allKeys]) {
        NSString* value = [[mutable objectForKey:key] description];
        [event setValue:value forCustomParameter:key];
    }
    
    [mutable release];
    
    return event;
}

// Log an un-timed event.
- (void)untimedEvent:(NSString*)eventName forObject:(id)object parameters:(NSDictionary*)parameters
{
    WTEvent* wtEvent = [self makeEventWithName:eventName forObject:object parameters:parameters];
    [self sendEventToWebtrends:wtEvent];
}

// Start logging a timed event. Returns the event, which can be ended by calling logTimedEventEnd:
- (ECAnalyticsEvent*)timedEventStart:(NSString*)eventName forObject:(id)object parameters:(NSDictionary*)parameters;
{
    WTEvent* wtEvent = [self makeEventWithName:eventName forObject:object parameters:parameters];
    [self sendEventToWebtrends:wtEvent];
    
	ECAnalyticsEvent* ourEvent = [[[ECAnalyticsEvent alloc] initWithName:eventName parameters:parameters] autorelease];
    ourEvent.object = object;
    
	return ourEvent;
}

// Finish logging a timed event.
- (void)timedEventEnd:(ECAnalyticsEvent*)ourEvent
{
    WTEvent* wtEvent = [self makeEventWithName:ourEvent.name forObject:ourEvent.object parameters:ourEvent.parameters];
    [self sendEventToWebtrends:wtEvent];
}


// Log an error.
- (void)error:(NSError*)error message:(NSString*)message
{
    NSString* safeMessage = [message stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    WTEvent* event = [WTEvent eventForError:safeMessage];
    [self addDictionary:[error userInfo] toEvent:event];
    [event setValue:[error localizedDescription] forCustomParameter:@"Error"];
    [event setValue:[NSString stringWithFormat:@"%ld", [error code]] forCustomParameter:@"Code"];
    [event setValue:[error domain] forCustomParameter:@"Domain"];
    
    [self sendEventToWebtrends:event];
}

// Log an exception.
- (void)exception:(NSException*)exception
{
    NSString* compact = [self compactStackFromException:exception];
    NSString* symbolic = [self symbolicStackFromException:exception];
    
    WTEvent* event = [WTEvent eventForError:@"Exception"];
    [self addDictionary:[exception userInfo] toEvent:event];
    [event setValue:[exception name] forCustomParameter:@"Name"];
    [event setValue:[exception reason] forCustomParameter:@"Reason"];
    [event setValue:compact forCustomParameter:@"Compact"];
    [event setValue:symbolic forCustomParameter:@"Symbolic"];
    
    [self sendEventToWebtrends:event];
}

@end
