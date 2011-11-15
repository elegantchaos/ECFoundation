// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 15/11/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------
#import "ECAnalyticsEvent.h"
#import "ECAnalyticsLogging.h"

@implementation ECAnalyticsEvent

@synthesize name;
@synthesize parameters;
@synthesize object;
@synthesize start;

// Initialise with an optional dictionary of event parameters.
- (id) initWithName:(NSString*)eventName parameters:(NSDictionary*)parametersOrNil;
{
	if ((self = [super init]) != nil)
	{
		self.name = eventName;
		if (parametersOrNil == nil)
		{
			parametersOrNil = [NSDictionary dictionary];
		}
		
		self.parameters = parametersOrNil;
        self.start = [NSDate date];
	}
	
	return self;
}

// Clean up and release retained objects.
- (void) dealloc
{
    [name release];
    [parameters release];
    [start release];
    
	[super dealloc];
}

// Update/append the values of some properties
- (void) updateParameters:(NSDictionary *)updates {
    NSMutableDictionary* updated = [self.parameters mutableCopy];
    [updated addEntriesFromDictionary:updates];
    self.parameters = updated;
}

// Clear out all the parameters
- (void) resetParameters {
	self.parameters = [NSDictionary dictionary];
}

// Return the time elapsed since this event was created
- (NSTimeInterval) elapsedTimeSinceStart {
    return -[self.start timeIntervalSinceNow];
}

// Return the time elapsed, quantised into one of a number of fixed values:
// "< 30 Seconds", "1 Minute", "2 Minutes", "4 Minutes", "8 Minutes", etc
- (NSString*) elapsedTimeSinceStartQuantised {
    NSString* result;
    
    double minutes = [self elapsedTimeSinceStart] / 60.0;
    if (minutes < 0.5)
    {
        result = @"< 30 Seconds";
    }
    else
    {
        double minutesLog = log2(minutes);
        double roundedLog = round(minutesLog);
        long roundedMinutes = pow(2.0, roundedLog);
        if (roundedMinutes > 1) {
            result = [NSString stringWithFormat:@"%ld Minutes", roundedMinutes];
        }
        else {
            result = @"1 Minute";
        }
    }
    
    return result;
}

@end
