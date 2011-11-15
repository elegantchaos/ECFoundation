// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 26/10/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "NSButton+ECCore.h"

@implementation NSButton (ECCore)

// --------------------------------------------------------------------------
//! Return the colour of the text.
//! (we actually return the colour of the first character, on the assumption
//!  that all the text is the same colour.
// --------------------------------------------------------------------------

- (NSColor*)textColour
{
    NSAttributedString* title = [self attributedTitle];
    NSUInteger length = [title length];
    NSRange range = NSMakeRange(0, MIN(length, 1));
    NSDictionary* attributes = [title fontAttributesInRange:range];
    NSColor* textColour;
    if (attributes)
	{
        textColour = [attributes objectForKey:NSForegroundColorAttributeName];
    }
	else
	{
		textColour = [NSColor controlTextColor];
	}
	
    return textColour;
}

// --------------------------------------------------------------------------
//! Set the colour of the text.
// --------------------------------------------------------------------------

- (void)setTextColour:(NSColor *)textColour
{
    NSMutableAttributedString* title = [[NSMutableAttributedString alloc] initWithAttributedString:[self attributedTitle]];
    NSUInteger length = [title length];
    NSRange range = NSMakeRange(0, length);
    [title addAttribute:NSForegroundColorAttributeName value:textColour range:range];
    [title fixAttributesInRange:range];
    [self setAttributedTitle:title];
    [title release];
}

@end

