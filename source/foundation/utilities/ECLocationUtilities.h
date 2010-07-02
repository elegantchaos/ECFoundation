// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 16/06/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

CLLocationCoordinate2D CoordinateClamp(CLLocationCoordinate2D value, CLLocationCoordinate2D min, CLLocationCoordinate2D max);
CLLocationCoordinate2D CoordinateMinimum(CLLocationCoordinate2D c1, CLLocationCoordinate2D c2);
CLLocationCoordinate2D CoordinateMaximum(CLLocationCoordinate2D c1, CLLocationCoordinate2D c2);
CLLocationCoordinate2D CoordinateCentre(CLLocationCoordinate2D c1, CLLocationCoordinate2D c2);
CLLocationCoordinate2D CoordinateDelta(CLLocationCoordinate2D c1, CLLocationCoordinate2D c2);
CLLocationCoordinate2D CoordinateFromArray(NSArray* array);

