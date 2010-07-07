// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 05/03/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Cocoa/Cocoa.h>

// --------------------------------------------------------------------------
//! Window which has no frame or titlebar.
// --------------------------------------------------------------------------

@interface ECTransparentWindow : NSWindow
{
    NSPoint mClickLocation;
}

@end
