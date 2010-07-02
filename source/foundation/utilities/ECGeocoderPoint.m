// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 01/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGeocoderPoint.h"

@implementation ECGeocoderPoint

@synthesize location = mLocation;
@synthesize bounds = mBounds;
@synthesize data = mData;

- (id) initWithDictionary: (NSDictionary*) data
{
	if ((self = [super init]) != nil)
	{
		self.data = data;
	}
	
	return self;
}

@end
