// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 05/10/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
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
