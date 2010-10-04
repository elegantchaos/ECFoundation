// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 05/10/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <CoreLocation/CoreLocation.h>

@interface CLLocation(ECUtilities)
{

}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (NSString*)	stringValue;
- (NSURL*)		urlForLocationInMap;
- (NSURL*)		urlForDirectionsFrom: (CLLocation*) from;

@end
