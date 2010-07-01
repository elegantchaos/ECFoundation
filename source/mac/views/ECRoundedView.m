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
    NSRect frameRect = [self frame];
    const CGFloat minX = NSMinX(frameRect);
    const CGFloat midX = NSMidX(frameRect);
    const CGFloat maxX = NSMaxX(frameRect);
    const CGFloat minY = NSMinY(frameRect);
    const CGFloat midY = NSMidY(frameRect);
    const CGFloat maxY = NSMaxY(frameRect);

    NSBezierPath* path = [NSBezierPath bezierPath];
    [path moveToPoint:NSMakePoint(midX, minY)];
    [path appendBezierPathWithArcFromPoint:NSMakePoint(maxX, minY) toPoint:NSMakePoint(maxX, midY) radius:mRadius];
    [path appendBezierPathWithArcFromPoint:NSMakePoint(maxX, maxY) toPoint:NSMakePoint(midX, maxY) radius:mRadius];
    [path appendBezierPathWithArcFromPoint:NSMakePoint(minX, maxY) toPoint:NSMakePoint(minX, midY) radius:mRadius];
    [path appendBezierPathWithArcFromPoint:frameRect.origin toPoint:NSMakePoint(midX, minY) radius:mRadius];
    [path closePath];
    
    NSColor* fillColour = [NSColor colorWithCalibratedWhite:0.0f alpha:mTransparency];
    [fillColour set];
    [path fill];
}


@end
