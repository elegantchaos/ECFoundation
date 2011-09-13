// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/12/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECRoundedImageCell.h"


// ==============================================
// Private Methods
// ==============================================

#pragma mark -
#pragma mark Private Methods

@interface ECRoundedImageCell()

@end


@implementation ECRoundedImageCell

// ==============================================
// Properties
// ==============================================

#pragma mark -
#pragma mark Properties

ECPropertySynthesize(cornerRadius);

// ==============================================
// Constants
// ==============================================

#pragma mark -
#pragma mark Constants

// ==============================================
// Lifecycle
// ==============================================

#pragma mark -
#pragma mark Lifecycle

- (void) awakeFromNib
{
	self.cornerRadius = 5.0f;
}

- (id)initImageCell:(NSImage *)image
{
	if ((self = [super initImageCell: image]) != nil)
	{
		self.cornerRadius = 5.0f;
	}
	
	return self;
}

// ==============================================
// Drawing
// ==============================================

#pragma mark -
#pragma mark Drawing

- (void)drawInteriorWithFrame:(NSRect)frame inView:(NSView *)controlView 
{
	[NSGraphicsContext saveGraphicsState];
	NSRect imageFrame = NSInsetRect(frame, 1, 1);
	CGFloat radius = self.cornerRadius;
	NSBezierPath* clipPath = [NSBezierPath bezierPathWithRoundedRect:imageFrame xRadius:radius yRadius: radius];
	[clipPath setWindingRule:NSEvenOddWindingRule];
	[clipPath addClip];
	[super drawInteriorWithFrame: frame inView: controlView];
	[NSGraphicsContext restoreGraphicsState];
}

@end
