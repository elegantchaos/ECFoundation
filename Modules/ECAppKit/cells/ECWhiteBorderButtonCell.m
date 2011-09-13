// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 09/12/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECWhiteBorderButtonCell.h"


// ==============================================
// Private Methods
// ==============================================

#pragma mark -
#pragma mark Private Methods

@interface ECWhiteBorderButtonCell()

@end


@implementation ECWhiteBorderButtonCell

// ==============================================
// Properties
// ==============================================

#pragma mark -
#pragma mark Properties

// ==============================================
// Constants
// ==============================================

#pragma mark -
#pragma mark Constants

// ==============================================
// Drawing
// ==============================================

#pragma mark -
#pragma mark Drawing

// --------------------------------------------------------------------------
//! Set up the object.
// --------------------------------------------------------------------------

- (void) awakeFromNib
{
	mRadius = 16.0f;

	if ([self bezelStyle] == NSRoundRectBezelStyle)
	{
		if ([self controlSize] == NSRegularControlSize)
		{
			mRadius = 10.0f;
		}
	}

}

- (NSRect)drawTitle:(NSAttributedString*)title withFrame:(NSRect)frame inView:(NSView*)controlView
{
	NSMutableAttributedString* mutable = [title mutableCopy];
	NSRange range = NSMakeRange(0, title.length);
	NSColor* color = [self isHighlighted] ? [NSColor blackColor] : [NSColor whiteColor];
	[mutable addAttribute: NSForegroundColorAttributeName value: color range: range];
	[mutable drawInRect: frame];
	[mutable release];
	
	return frame;
}

- (void)drawBezelWithFrame:(NSRect)frame inView:(NSView*)controlView
{
	frame = NSInsetRect(frame, 1.0f, 1.0f);
	NSBezierPath* path = [NSBezierPath bezierPathWithRoundedRect: frame xRadius: mRadius yRadius: mRadius];
	path.lineWidth = 2.0f;
    [[NSColor whiteColor] set];
    [path stroke];
	
	if ([self isHighlighted])
	{
		[[NSColor whiteColor] setFill];
		[path fill];
	}
}

@end
