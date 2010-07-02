// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 01/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

@interface ECGeocoderPoint : NSObject
{
	CLLocationCoordinate2D	mLocation;
	NSDictionary*			mData;
}


@property (assign, nonatomic, readonly)	CLLocationCoordinate2D	location;
@property (retain, nonatomic) NSDictionary*						data;

- (id) initWithLocation: (CLLocationCoordinate2D) location andData: (NSDictionary*) data;

@end
