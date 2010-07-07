// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 01/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGeocoderPointCloudmade.h"
#import "ECLocationUtilities.h"
#import "ECMapUtilities.h"

@implementation ECGeocoderPointCloudmade

- (id) initWithDictionary: (NSDictionary*) data
{
	if ((self = [super initWithDictionary: data]) != nil)
	{
		NSDictionary* centroid = [data valueForKey: @"centroid"];
		NSArray* centre = [centroid valueForKey: @"coordinates"];
		mLocation = CoordinateFromArray(centre);
		
		NSArray* bounds = [data valueForKey: @"bounds"];
		CLLocationCoordinate2D min = CoordinateFromArray([bounds objectAtIndex: 0]);
		CLLocationCoordinate2D max = CoordinateFromArray([bounds objectAtIndex: 1]);
		mBounds = RegionFromCoordinates(min, max);
	}
	
	return self;
}

@end
