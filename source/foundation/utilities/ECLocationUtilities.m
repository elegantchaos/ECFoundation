// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 16/06/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECLocationUtilities.h"

// --------------------------------------------------------------------------
//! Clamp a coordinate between a minimum and maximum value.
// --------------------------------------------------------------------------

CLLocationCoordinate2D CoordinateClamp(CLLocationCoordinate2D value, CLLocationCoordinate2D min, CLLocationCoordinate2D max)
{
	CLLocationCoordinate2D result = CoordinateMinimum(value, max);
	result = CoordinateMaximum(result, min);
	
	return result;
}

// --------------------------------------------------------------------------
//! Return a coordinate which is the composite of the minimum
//! latitude and longitude values of two other coordinates.
// --------------------------------------------------------------------------

CLLocationCoordinate2D CoordinateMinimum(CLLocationCoordinate2D c1, CLLocationCoordinate2D c2)
{
	CLLocationCoordinate2D result = 
	{
		(c1.latitude < c2.latitude) ? c1.latitude : c2.latitude,
		(c1.longitude < c2.longitude) ? c1.longitude : c2.longitude
	};
	
	return result;
}

// --------------------------------------------------------------------------
//! Return a coordinate which is the composite of the maximum
//! latitude and longitude values of two other coordinates.
// --------------------------------------------------------------------------

CLLocationCoordinate2D CoordinateMaximum(CLLocationCoordinate2D c1, CLLocationCoordinate2D c2)
{
	CLLocationCoordinate2D result = 
	{
		(c1.latitude > c2.latitude) ? c1.latitude : c2.latitude,
		(c1.longitude > c2.longitude) ? c1.longitude : c2.longitude
	};
	
	return result;
}

// --------------------------------------------------------------------------
//! Return the mid-point of two coordinates.
// --------------------------------------------------------------------------

CLLocationCoordinate2D CoordinateCentre(CLLocationCoordinate2D c1, CLLocationCoordinate2D c2)
{
	CLLocationCoordinate2D result = 
	{
		(c1.latitude + c2.latitude) / 2.0,
		(c1.longitude + c2.longitude) / 2.0
	};
	
	return result;
	
}

// --------------------------------------------------------------------------
//! Return the delta to apply to c1 to give c2.
// --------------------------------------------------------------------------

CLLocationCoordinate2D CoordinateDelta(CLLocationCoordinate2D c1, CLLocationCoordinate2D c2)
{
	CLLocationCoordinate2D result = 
	{
		(c2.latitude - c1.latitude),
		(c2.longitude - c1.longitude)
	};
	
	return result;
	
}

// --------------------------------------------------------------------------
//! Given an array return a coordinate. The first two items of the
//! array are assumed to be doubles.
// --------------------------------------------------------------------------

CLLocationCoordinate2D CoordinateFromArray(NSArray* array)
{
	ECAssertNonNilC(array);
	ECAssertCountAtLeastC(array, 2);
	
	CLLocationCoordinate2D result;
	result.latitude = [[array objectAtIndex: 0] doubleValue];
	result.longitude = [[array objectAtIndex: 1] doubleValue];
	
	return result;
}
