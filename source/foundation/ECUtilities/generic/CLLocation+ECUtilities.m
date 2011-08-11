// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "CLLocation+ECUtilities.h"

@implementation CLLocation(ECUtilities)

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
// Constants
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
// Methods
// --------------------------------------------------------------------------

- (NSString*) stringValue
{
	CLLocationCoordinate2D coordinate = self.coordinate;
	NSString* result = [NSString stringWithFormat: @"%lf,%lf", coordinate.latitude, coordinate.longitude];

	return result;
}

- (NSURL*) urlForLocationInMap
{
	CLLocationCoordinate2D coordinate = self.coordinate;
	NSString* string = [[NSString alloc] initWithFormat: @"http://maps.google.com/maps?ll=%lf,%lf", coordinate.latitude, coordinate.longitude];
	NSURL* result = [NSURL URLWithString: string];
	[string release];
	
	return result;
}

- (NSURL*) urlForDirectionsFrom: (CLLocation*) from
{
	CLLocationCoordinate2D coordinate = self.coordinate;
	NSString* string = [[NSString alloc] initWithFormat: @"http://maps.google.com/maps?ll=%lf,%lf", coordinate.latitude, coordinate.longitude];
	NSURL* result = [NSURL URLWithString: string];
	[string release];
	
	return result;	
}

@end
