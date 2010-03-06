// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 05/03/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECTransparentWindow.h"

@implementation ECTransparentWindow

// --------------------------------------------------------------------------

- (id) initWithContentRect:(NSRect)contentRect 
                 styleMask:(NSUInteger)aStyle 
                   backing:(NSBackingStoreType)bufferingType 
                     defer:(BOOL)flag 
{
    if (self = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:bufferingType defer:flag]) 
	{
        [self setLevel: NSStatusWindowLevel];
        [self setBackgroundColor: [NSColor clearColor]];
        [self setAlphaValue:1.0];
        [self setOpaque:NO];
        [self setHasShadow:NO];
    }
    
	return self;
}

// --------------------------------------------------------------------------

- (BOOL) canBecomeKeyWindow
{
    return YES;
}

// --------------------------------------------------------------------------

- (NSRect) pinRect: (NSRect) inputRect toRect: (NSRect) pinningRect
{
	NSRect result = inputRect;
	
	if (result.origin.x < pinningRect.origin.x)
	{
		result.origin.x = pinningRect.origin.x;
	}
	else if ((result.origin.x + result.size.width) > (pinningRect.origin.x + pinningRect.size.width))
	{
		result.origin.x = pinningRect.origin.x + pinningRect.size.width - result.size.width;
	}

	if (result.origin.y < pinningRect.origin.y)
	{
		result.origin.y = pinningRect.origin.y;
	}
	else if ((result.origin.y + result.size.height) > (pinningRect.origin.y + pinningRect.size.height))
	{
		result.origin.y = pinningRect.origin.y + pinningRect.size.height - result.size.height;
	}
	
	return inputRect;
}

- (void) mouseDragged: (NSEvent*) theEvent
{
    NSPoint currentLocation;
    NSPoint newOrigin;
    NSRect  screenFrame = [[NSScreen mainScreen] visibleFrame];
    NSRect  windowFrame = [self frame];
    
    currentLocation = [self convertBaseToScreen:[self mouseLocationOutsideOfEventStream]];
    newOrigin.x = currentLocation.x - mClickLocation.x;
    newOrigin.y = currentLocation.y - mClickLocation.y;
    windowFrame.origin = newOrigin;

	windowFrame = [self pinRect: windowFrame toRect: screenFrame];
    
    [self setFrameOrigin:windowFrame.origin];
}

// --------------------------------------------------------------------------

- (void) mouseDown: (NSEvent*)theEvent
{    
    NSRect windowFrame = [self frame];
    
    // Get mouse location in global coordinates
    mClickLocation = [self convertBaseToScreen:[theEvent locationInWindow]];
    mClickLocation.x -= windowFrame.origin.x;
    mClickLocation.y -= windowFrame.origin.y;
}


@end
