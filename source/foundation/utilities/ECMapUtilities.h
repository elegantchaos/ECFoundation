// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 16/06/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

MKCoordinateSpan SpanFromCoordinates(CLLocationCoordinate2D min, CLLocationCoordinate2D max);
MKCoordinateRegion RegionFromCoordinates(CLLocationCoordinate2D min, CLLocationCoordinate2D max);
