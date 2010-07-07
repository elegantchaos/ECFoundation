// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 16/06/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECMapUtilities.h"
#import "ECLocationUtilities.h"

// --------------------------------------------------------------------------
//! Return the span between two coordinates.
// --------------------------------------------------------------------------

MKCoordinateSpan SpanFromCoordinates(CLLocationCoordinate2D min, CLLocationCoordinate2D max)
{
	CLLocationCoordinate2D delta = CoordinateDelta(min, max);
	MKCoordinateSpan result;
	
	result.latitudeDelta = delta.latitude;
	result.longitudeDelta = delta.longitude;
	
	return result;
}

// --------------------------------------------------------------------------
//! Return the region between two coordinates.
// --------------------------------------------------------------------------

MKCoordinateRegion RegionFromCoordinates(CLLocationCoordinate2D min, CLLocationCoordinate2D max)
{
	MKCoordinateRegion result;
	
	result.span = SpanFromCoordinates(min, max);
	result.center = CoordinateCentre(min, max);
	return result;
}
