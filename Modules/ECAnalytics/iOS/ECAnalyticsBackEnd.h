// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 15/11/2011
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
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

#pragma mark - Public Properties

@property (nonatomic, retain) ECAnalyticsEngine* engine;

#pragma mark - Public Methods

- (void)startupWithEngine:(ECAnalyticsEngine*)engine;
- (void)shutdown;
- (void)suspend;
- (void)resume;
- (void)eventUntimed:(NSString*)event forObject:(id)object parameters:(NSDictionary*)parameters;
- (ECAnalyticsEvent*)eventStart:(NSString*)event forObject:(id)object parameters:(NSDictionary*)parameters;
- (void)eventEnd:(ECAnalyticsEvent*)event;
- (void)error:(NSError*)error message:(NSString*)message;
- (void)exception:(NSException*)exception;
- (BOOL)hasOwnExceptionHandler;

@end
