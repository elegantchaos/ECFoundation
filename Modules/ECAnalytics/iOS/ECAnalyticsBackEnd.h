// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 15/11/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@class ECAnalyticsEvent;
@class ECAnalyticsEngine;

// --------------------------------------------------------------------------
//! Abstraction of an analytics back-end. Subclasses should be implemented
//! for a particular system - eg Flurry, Webtrends, TestFlight etc.
// --------------------------------------------------------------------------

@interface ECAnalyticsBackEnd : NSObject

@property (nonatomic, retain) ECAnalyticsEngine* engine;

// Methods To Override
- (void)startupWithEngine:(ECAnalyticsEngine*)engine;
- (void)shutdown;
- (void)suspend;
- (void)resume;
- (void)untimedEvent:(NSString*)event forObject:(id)object parameters:(NSDictionary*)parameters;
- (ECAnalyticsEvent*)timedEventStart:(NSString*)event forObject:(id)object parameters:(NSDictionary*)parameters;
- (void)timedEventEnd:(ECAnalyticsEvent*)event;
- (void)error:(NSError*)error message:(NSString*)message;
- (void)exception:(NSException*)exception;
- (BOOL)hasOwnExceptionHandler;

@end
