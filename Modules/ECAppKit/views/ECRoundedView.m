// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 05/03/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECRoundedView.h"

@implementation ECRoundedView

ECPropertySynthesize(colour);
ECPropertySynthesize(radius);


- (void) setupDefaults
{
	self.radius = 25.0f;
	self.colour = [NSColor colorWithCalibratedWhite:0.0f alpha:0.75f];
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
	CGFloat radius = self.radius;
    NSBezierPath* path = [NSBezierPath bezierPathWithRoundedRect: [self frame] xRadius: radius yRadius: radius];
    [self.colour set];
    [path fill];
}


@end
