// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 02/04/2011
//
//! @file Additional methods for the NSWindow class.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "NSWindow+ECCore.h"
#import "NSGeometry+ECCore.h"

@implementation NSWindow(ECCore)

// --------------------------------------------------------------------------
//! Return the frame of the window, centred on the screen it's already on.
//! @return the centred frame of the window.
// --------------------------------------------------------------------------

- (NSRect)frameCentredOnCurrentScreen
{
    NSRect centredFrame = NSSetCentre(self.frame, NSCentre(self.screen.frame));
    return centredFrame;
}

// --------------------------------------------------------------------------
//! Return the frame of the window, centred on the main screen.
//! @return the centred frame of the window.
// --------------------------------------------------------------------------

- (NSRect)frameCentredOnMainScreen
{
    NSRect centredFrame = NSSetCentre(self.frame, NSCentre([NSScreen mainScreen].frame));
    return centredFrame;
}

// --------------------------------------------------------------------------
//! Centre the window on the screen that it is currently on.
//! @return the old frame of the window.
// --------------------------------------------------------------------------

- (NSRect)centreOnCurrentScreen
{
    NSRect oldFrame = self.frame;
    NSRect centredFrame = NSSetCentre(oldFrame, NSCentre(self.screen.frame));
    
    [self setFrame:centredFrame display:YES animate:YES];
    return oldFrame;
}

// --------------------------------------------------------------------------
//! Centre the window on the main screen.
//! @return the old frame of the window.
// --------------------------------------------------------------------------

- (NSRect)centreOnMainScreen
{
    NSRect oldFrame = self.frame;
    NSRect centredFrame = NSSetCentre(oldFrame, NSCentre([NSScreen mainScreen].frame));
    
    [self setFrame:centredFrame display:YES animate:YES];
    return oldFrame;
}


@end
