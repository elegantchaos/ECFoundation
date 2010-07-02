// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 01/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGeocoderPoint.h"

@implementation ECGeocoderPoint

@synthesize location = mLocation;
@synthesize data = mData;

- (id) initWithLocation: (CLLocationCoordinate2D) location andData: (NSDictionary*) data
{
	if ((self = [super init]) != nil)
	{
		mLocation = location;
		self.data = data;
	}
	
	return self;
}

@end
