// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 05/03/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECRoundedView.h"

@implementation ECRoundedView

@synthesize transparency = mTransparency;
@synthesize radius = mRadius;


- (void) setupDefaults
{
	self.radius = 25.0f;
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
    NSBezierPath* path = [NSBezierPath bezierPathWithRoundedRect: [self frame] xRadius: mRadius yRadius: mRadius];
    NSColor* fillColour = [NSColor colorWithCalibratedWhite:0.0f alpha:mTransparency];
    [fillColour set];
    [path fill];
}


@end
