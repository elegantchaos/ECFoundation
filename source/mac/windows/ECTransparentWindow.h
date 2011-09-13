// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 05/03/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Cocoa/Cocoa.h>

// --------------------------------------------------------------------------
//! Window which has no frame or titlebar.
// --------------------------------------------------------------------------

@interface ECTransparentWindow : NSWindow
{
    NSPoint		mClickLocation;
	BOOL		mResizable;
	CGFloat		mResizeRectSize;
}

@end
