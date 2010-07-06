// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 01/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <MapKit/MapKit.h>

@interface ECGeocoderPoint : NSObject
{
	CLLocationCoordinate2D	mLocation;
	MKCoordinateRegion		mBounds;
	NSDictionary*			mData;
}


@property (assign, nonatomic, readonly)	CLLocationCoordinate2D	location;
@property (assign, nonatomic, readonly)	MKCoordinateRegion		bounds;
@property (retain, nonatomic) NSDictionary*						data;

- (id) initWithDictionary: (NSDictionary*) data;

@end
