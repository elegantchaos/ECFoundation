// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 08/09/2010
//
//! @file Additional utilities for working with Launch Services.
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>


@interface ECLaunchServices : NSObject 
{

}

// --------------------------------------------------------------------------
//! Public methods.
// --------------------------------------------------------------------------

+ (BOOL) willOpenAtLogin: (NSURL*)itemURL;
+ (void) setOpenAtLogin: (NSURL*)itemURL enabled: (BOOL) enabled;

@end
