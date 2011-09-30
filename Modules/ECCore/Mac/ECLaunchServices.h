// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 08/09/2010
//
//! @file Additional utilities for working with Launch Services.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
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
