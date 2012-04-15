// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 05/03/2010
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECRoundedView.h"

@interface ECRoundedView()

@property (nonatomic, retain) NSBezierPath* path;

- (void)makePathForRect:(CGRect)rect;

@end

@implementation ECRoundedView

@synthesize gradient;
@synthesize path;
@synthesize radius;

static const CGFloat kStartAlpha = 0.8;
static const CGFloat kEndAlpha = 0.65;
static const CGFloat kDefaultRadius = 25.0;

- (void) setupDefaults
{
	self.radius = kDefaultRadius;
	NSColor* start = [NSColor colorWithCalibratedWhite:0.0f alpha:kStartAlpha];
	NSColor* end = [start colorWithAlphaComponent:kEndAlpha];
	self.gradient = [[[NSGradient alloc] initWithStartingColor:start endingColor:end] autorelease];
}

// --------------------------------------------------------------------------
//! Initialise default values for properties.
// --------------------------------------------------------------------------

- (id) initWithFrame:(NSRect)frameRect
{
	if ((self = [super initWithFrame: frameRect]) != nil)
	{
		[self setupDefaults];
		[self makePathForRect:frameRect];
	}
	
	return self;
}

- (void)dealloc
{
	[gradient release];
	[path release];
	
	[super dealloc];
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

- (void) awakeFromNib
{
	[self setupDefaults];
	[self makePathForRect:self.frame];
	[super awakeFromNib];
}

- (void)setFrame:(NSRect)frameRect
{
	[super setFrame:frameRect];
	[self makePathForRect:frameRect];
}

- (void)setFrameSize:(NSSize)newSize
{
	[super setFrameSize:newSize];
	[self makePathForRect:self.frame];
}

- (void)setFrameOrigin:(NSPoint)newOrigin
{
	[super setFrameOrigin:newOrigin];
	[self makePathForRect:self.frame];
}

- (void)makePathForRect:(CGRect)rect
{
	self.path = [NSBezierPath bezierPathWithRoundedRect:rect xRadius:self.radius yRadius:self.radius];
}
// --------------------------------------------------------------------------
//! Draw the view.
// --------------------------------------------------------------------------

- (void) drawRect: (NSRect) dirtyRect
{
	[self.gradient drawInBezierPath:self.path angle:90.0];
}


@end
