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

// Represents an analytics event. 
// Analytics Engine implementations can use this class as it is, or subclass if they need to associate other information with each event.

@interface ECAnalyticsEvent : NSObject 

@property (copy, nonatomic) NSDictionary* parameters;       // Dictionary of event parameters
@property (copy, nonatomic) NSString* name;                 // Event name
@property (retain, nonatomic) NSDate* start;                // Time when the event started
@property (assign, nonatomic) id object;                    // Optional user-supplied reference to the object the event is about.

- (id) initWithName:(NSString*)name parameters:(NSDictionary*)parametersOrNil;
- (void) resetParameters;
- (void) updateParameters:(NSDictionary*)updates;
- (NSTimeInterval) elapsedTimeSinceStart;
- (NSString*) elapsedTimeSinceStartQuantised;

@end
