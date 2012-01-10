// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 05/03/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTransparentWindow.h"

#import "NSApplication+ECCore.h"

@interface ECTransparentWindow()

@property (nonatomic, assign) BOOL isLion;

@end

@implementation ECTransparentWindow

@synthesize isLion;

static const CGFloat kDefaultResizeRectSize = 32;

- (id) initWithContentRect:(NSRect)contentRect 
                 styleMask:(NSUInteger)aStyle 
                   backing:(NSBackingStoreType)bufferingType 
                     defer:(BOOL)flag 
{
	self.isLion = [NSApplication isLionOrGreater];
	
	NSUInteger mask = NSBorderlessWindowMask;
	if (self.isLion && (aStyle & NSResizableWindowMask))
	{
		mask |= NSResizableWindowMask;
	}
	
    if ((self = [super initWithContentRect:contentRect styleMask:mask backing:bufferingType defer:flag]) != nil) 
	{
		mResizeRectSize = kDefaultResizeRectSize;
		mResizable = (aStyle & NSResizableWindowMask) != 0;
		
        [self setLevel: NSStatusWindowLevel];
        [self setBackgroundColor: [NSColor clearColor]];
        [self setAlphaValue:1.0f];
        [self setOpaque:NO];
        [self setHasShadow:YES];
		[self setShowsResizeIndicator: YES];
		[self setMovableByWindowBackground:YES];
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

#if 0
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
#endif

- (NSPoint)getEventLocation:(NSEvent*)event isResize:(BOOL*)isResize
{
    NSRect windowFrame = [self frame];
    
    // Get mouse location in global coordinates
    mClickLocation = [self convertBaseToScreen:[event locationInWindow]];
    mClickLocation.x -= windowFrame.origin.x;
    mClickLocation.y -= windowFrame.origin.y;
	
	NSPoint pointInView = [event locationInWindow];
	
	NSRect resizeRect = NSMakeRect(self.frame.size.width - mResizeRectSize, 0, mResizeRectSize, mResizeRectSize);	
	*isResize = mResizable && NSPointInRect(pointInView, resizeRect);
	
	NSPoint originalMouseLocation = [self convertBaseToScreen:[event locationInWindow]];

	return originalMouseLocation;
}

#if 0
- (void)mouseMoved:(NSEvent*)event
{
	[super mouseMoved:event];

	BOOL resize;
	[self getEventLocation:event isResize:&resize];
	if (resize)
	{
		[[NSCursor resizeDownCursor] set];
	}
	else
	{
		[[NSCursor pointingHandCursor] set];
	}
}
#endif

// --------------------------------------------------------------------------
//
// mouseDown:
//
// Handles mouse clicks in our frame. Two actions:
//	- click in the resize box should resize the window
//	- click anywhere else will drag the window.
//
- (void)mouseDown:(NSEvent *)event
{
	if (self.isLion)
	{
		[super mouseDown:event];
	}
	else
	{
		BOOL resize;
		NSPoint originalMouseLocation = [self getEventLocation:event isResize:&resize];
		NSRect originalFrame = [self frame];
		
		while (YES)
		{
			//
			// Lock focus and take all the dragged and mouse up events until we
			// receive a mouse up.
			//
			NSEvent *newEvent = [self
								 nextEventMatchingMask:(NSLeftMouseDraggedMask | NSLeftMouseUpMask)];
			
			if ([newEvent type] == NSLeftMouseUp)
			{
				break;
			}
			
			//
			// Work out how much the mouse has moved
			//
			NSPoint newMouseLocation = [self convertBaseToScreen:[newEvent locationInWindow]];
			NSPoint delta = NSMakePoint(
										newMouseLocation.x - originalMouseLocation.x,
										newMouseLocation.y - originalMouseLocation.y);
			
			NSRect newFrame = originalFrame;
			
			if (!resize)
			{
				//
				// Alter the frame for a drag
				//
				newFrame.origin.x += delta.x;
				newFrame.origin.y += delta.y;
			}
			else
			{
				//
				// Alter the frame for a resize
				//
				newFrame.size.width += delta.x;
				newFrame.size.height -= delta.y;
				newFrame.origin.y += delta.y;
				
				//
				// Constrain to the window's min and max size
				//
				NSRect newContentRect = [self contentRectForFrameRect:newFrame];
				NSSize maxSize = [self maxSize];
				NSSize minSize = [self minSize];
				if (newContentRect.size.width > maxSize.width)
				{
					newFrame.size.width -= newContentRect.size.width - maxSize.width;
				}
				else if (newContentRect.size.width < minSize.width)
				{
					newFrame.size.width += minSize.width - newContentRect.size.width;
				}
				if (newContentRect.size.height > maxSize.height)
				{
					newFrame.size.height -= newContentRect.size.height - maxSize.height;
					newFrame.origin.y += newContentRect.size.height - maxSize.height;
				}
				else if (newContentRect.size.height < minSize.height)
				{
					newFrame.size.height += minSize.height - newContentRect.size.height;
					newFrame.origin.y -= minSize.height - newContentRect.size.height;
				}
			}
			
			[self setFrame:newFrame display:YES animate:NO];
		}
	}
}

@end
