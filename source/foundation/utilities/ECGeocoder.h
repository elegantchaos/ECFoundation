// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 01/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>


@interface ECGeocoder : NSObject
{
	NSStringEncoding	mEncoding;
}

- (void) lookup: (NSString*) stringToEncode;

@end
