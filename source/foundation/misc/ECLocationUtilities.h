// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#include <CoreLocation/CoreLocation.h>

BOOL CoordinatesEqual(CLLocationCoordinate2D value1, CLLocationCoordinate2D value2);

CLLocationCoordinate2D CoordinateClamp(CLLocationCoordinate2D value, CLLocationCoordinate2D min, CLLocationCoordinate2D max);
CLLocationCoordinate2D CoordinateMinimum(CLLocationCoordinate2D c1, CLLocationCoordinate2D c2);
CLLocationCoordinate2D CoordinateMaximum(CLLocationCoordinate2D c1, CLLocationCoordinate2D c2);
CLLocationCoordinate2D CoordinateCentre(CLLocationCoordinate2D c1, CLLocationCoordinate2D c2);
CLLocationCoordinate2D CoordinateDelta(CLLocationCoordinate2D c1, CLLocationCoordinate2D c2);
CLLocationCoordinate2D CoordinateFromArray(NSArray* array);

