// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 01/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@class ECGeocoder;
@protocol ECGeocoderDelegate;


@interface ECGeocoder : NSObject
{
	NSStringEncoding		mEncoding;
	NSMutableString*		mRawJSON;
	id<ECGeocoderDelegate>	mDelegate;
}

@property (retain, nonatomic) id<ECGeocoderDelegate> delegate;

- (void) lookup: (NSString*) stringToEncode;

@end

@protocol ECGeocoderDelegate <NSObject>

- (void) geocoder: (ECGeocoder*) geocoder foundPoints: (NSArray*) points;

@end
