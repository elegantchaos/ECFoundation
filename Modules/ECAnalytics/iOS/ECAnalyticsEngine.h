// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 15/11/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

typedef enum 
{
    DebugOutputOff,
    DebugOutputOn,
    DebugOutputVerbose
} DebugOutputLevel;

@class ECAnalyticsEvent;
@class ECAnalyticsBackEnd;

// --------------------------------------------------------------------------
//! Public interface to the analytics system.
// --------------------------------------------------------------------------

@interface ECAnalyticsEngine : NSObject 

@property (assign, nonatomic) DebugOutputLevel debugLevel;

- (id)initWithBackEnd:(ECAnalyticsBackEnd*)backEnd;
- (id)initWithBackEndClass:(Class)backEndClass;
- (id)initWithBackEndNamed:(NSString*)backEndClassName;

// Engine management
- (void)startupInstallingExceptionHandler:(BOOL)installingExceptionHandler;
- (void)shutdown;
- (void)suspend;
- (void)resume;

// Event name encoding
- (void)setEncodingParameters:(NSArray*)parameters forEventName:(NSString*)eventName;

// Event parameters
- (NSMutableDictionary*)parametersForObject:(NSObject*)object forEvent:(NSString*)eventName;

// Event logging
- (void)logUntimedEvent:(NSString*)event forObject:(id)object;
- (ECAnalyticsEvent*)logTimedEventStart:(NSString*)event forObject:(id)object;
- (void)logTimedEventEnd:(ECAnalyticsEvent*)event;
- (void)logError:(NSError*)errorOrNil message:(NSString*)messageOrNil;
- (void)logException:(NSException*)exception;

@end
