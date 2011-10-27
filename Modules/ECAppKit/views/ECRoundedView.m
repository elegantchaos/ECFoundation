// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 05/03/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECRoundedView.h"

@interface ECRoundedView()

@property (nonatomic, retain) NSGradient* gradient;

@end

@implementation ECRoundedView

@synthesize colour;
@synthesize gradient;
@synthesize radius;


- (void) setupDefaults
{
	self.radius = 25.0f;
	self.colour = [NSColor colorWithCalibratedWhite:0.0f alpha:0.8f];
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
	NSGradient* gr = self.gradient;
	if (!gr)
	{
		NSColor* start = self.colour;
		NSColor* end = [start colorWithAlphaComponent:0.65];
		gr = [[NSGradient alloc] initWithStartingColor:start endingColor:end];
		self.gradient = gr;
		[gr release];
	}
	
    NSBezierPath* path = [NSBezierPath bezierPathWithRoundedRect:[self frame] xRadius:self.radius yRadius:self.radius];
	[gr drawInBezierPath:path angle:90.0];
	//    [self.colour set];
	//    [path fill];
}


@end
