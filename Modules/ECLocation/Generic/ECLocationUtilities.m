// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECLocationUtilities.h"
#import "ECAssertion.h"

BOOL CoordinatesEqual(CLLocationCoordinate2D value1, CLLocationCoordinate2D value2)
{
	return (value1.latitude == value2.latitude) && (value1.longitude == value2.longitude);
}

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
