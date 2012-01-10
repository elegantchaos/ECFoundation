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

// --------------------------------------------------------------------------
//! An abstract event the represent something happening in the client application
// --------------------------------------------------------------------------

@interface ECAnalyticsEvent : NSObject 

#pragma mark - Public Properties

@property (copy, nonatomic) NSDictionary* parameters;       //!< Dictionary of event parameters
@property (copy, nonatomic) NSString* name;                 //!< Event name
@property (retain, nonatomic) NSDate* start;                //!< Time when the event started
@property (assign, nonatomic) id object;                    //!< Optional user-supplied reference to the object the event is about.

#pragma mark - Public Methods

- (id)initWithName:(NSString*)name parameters:(NSDictionary*)parametersOrNil;
- (void)resetParameters;
- (void)updateParameters:(NSDictionary*)updates;
- (NSTimeInterval)elapsedTimeSinceStart;
- (NSString*)elapsedTimeSinceStartQuantised;

@end
