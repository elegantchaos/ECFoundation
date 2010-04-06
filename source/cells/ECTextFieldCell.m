//
//  ECTextFieldCell.m
//  replicator
//
//! @author Sam Deane
//! @date 25/01/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
//

#import "ECTextFieldCell.h"


@implementation ECTextFieldCell

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
	ECDebug(@"set att");
	
	NSMutableAttributedString* modified = [obj mutableCopy];

	[super setAttributedStringValue:modified];
}

- (NSRect)titleRectForBounds:(NSRect)theRect 
{
    NSRect titleFrame = [super titleRectForBounds:theRect];
    NSSize titleSize = [[self attributedStringValue] size];
    titleFrame.origin.y = theRect.origin.y - .5 + (theRect.size.height - titleSize.height) / 2.0;
    return titleFrame;
}

- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView 
{
    NSRect titleRect = [self titleRectForBounds:cellFrame];
    [[self attributedStringValue] drawInRect:titleRect];
}

@end
