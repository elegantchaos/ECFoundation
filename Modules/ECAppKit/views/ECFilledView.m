// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 05/03/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECFilledView.h"

@implementation ECFilledView

@synthesize transparency = mTransparency;


- (void) setupDefaults
{
	self.transparency = 0.75f;
}

// --------------------------------------------------------------------------
//! Initialise default values for properties.
// --------------------------------------------------------------------------

- (id) initWithFrame:(NSRect)frameRect
{
	if ((self = [super initWithFrame: frameRect]) != nil)
	{
		[self setupDefaults];
	}
	
	return self;
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

- (void) awakeFromNib
{
	[self setupDefaults];
	[super awakeFromNib];
}


// --------------------------------------------------------------------------
//! Draw the view.
// --------------------------------------------------------------------------

- (void) drawRect: (NSRect) dirtyRect
{
    NSBezierPath* path = [NSBezierPath bezierPathWithRect: [self frame]];
	//    NSColor* fillColour = [NSColor colorWithCalibratedWhite:0.0f alpha:mTransparency];
	    NSColor* fillColour = [NSColor redColor];
    [fillColour set];
    [path fill];
}


@end
