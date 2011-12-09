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

#pragma mark - Properties

@property (assign, nonatomic) DebugOutputLevel debugLevel;

#pragma mark - Instances

- (id)initWithBackEnd:(ECAnalyticsBackEnd*)backEnd;
- (id)initWithBackEndClass:(Class)backEndClass;
- (id)initWithBackEndNamed:(NSString*)backEndClassName;

#pragma mark - Engine management

- (void)startupUsingExceptionHandler:(BOOL)installingExceptionHandler;
- (void)shutdown;
- (void)suspend;
- (void)resume;

#pragma mark - Event name encoding

- (void)setEncodingParameters:(NSArray*)parameters forEventName:(NSString*)eventName;

#pragma mark - Event parameters

- (NSMutableDictionary*)parametersForObject:(NSObject*)object forEvent:(NSString*)eventName;

#pragma mark - Event logging

- (void)logEvent:(NSString*)event forObject:(id)object;
- (ECAnalyticsEvent*)logEventStart:(NSString*)event forObject:(id)object;
- (void)logEventEnd:(ECAnalyticsEvent*)event;
- (void)logError:(NSError*)errorOrNil message:(NSString*)messageOrNil;
- (void)logException:(NSException*)exception;

@end
