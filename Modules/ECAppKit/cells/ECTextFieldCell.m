//
//  ECTextFieldCell.m
//
//! @author Sam Deane
//! @date 25/01/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
//

#import "ECTextFieldCell.h"


@implementation ECTextFieldCell

ECDefineDebugChannel(ECTextFieldChannel);

- (id)initTextCell:(NSString *)aString
{
	return [super initTextCell:@"blah"];
}

- (void)setStringValue:(NSString *)aString
{
	[super setStringValue:@"blah"];
}

- (void)setAttributedStringValue:(NSAttributedString *)obj
{
	ECDebug(ECTextFieldChannel, @"set att");
	
	NSMutableAttributedString* modified = [obj mutableCopy];

	[super setAttributedStringValue:modified];
	
	[modified release];
}

- (NSRect)titleRectForBounds:(NSRect)theRect 
{
    NSRect titleFrame = [super titleRectForBounds:theRect];
    NSSize titleSize = [[self attributedStringValue] size];
    titleFrame.origin.y = theRect.origin.y - 0.5f + (theRect.size.height - titleSize.height) / 2.0f;
    return titleFrame;
}

- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView 
{
    NSRect titleRect = [self titleRectForBounds:cellFrame];
    [[self attributedStringValue] drawInRect:titleRect];
}

@end
