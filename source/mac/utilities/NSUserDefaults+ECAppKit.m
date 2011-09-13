// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/12/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "NSUserDefaults+ECAppKit.h"


@implementation NSUserDefaults(ECAppKit)

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

static NSString *const kFontNameKey = @"Name";
static NSString *const kFontSizeKey = @"Size";

// ==============================================
// Font Support
// ==============================================

#pragma mark -
#pragma mark Font Support

// --------------------------------------------------------------------------
//! Read a font name and size from the defaults.
// --------------------------------------------------------------------------

- (NSFont*) fontForKey: (NSString*) key
{
	NSDictionary* info = [self objectForKey: key];
	NSString* fontName = [info objectForKey: kFontNameKey];
	CGFloat fontSize = [[info objectForKey: kFontSizeKey] floatValue];
	
	NSFont* result = nil;
	if (fontName && fontSize)
	{
		result = [NSFont fontWithName: fontName size: fontSize];
	}
	
	return result;
}

// --------------------------------------------------------------------------
//! Save a font name and size to the defaults.
// --------------------------------------------------------------------------

- (void) setFont: (NSFont*) font forKey: (NSString*) key
{
	NSDictionary* info = [[NSDictionary alloc] initWithObjectsAndKeys: [font fontName], kFontNameKey, [NSNumber numberWithDouble: [font pointSize]], kFontSizeKey, nil];
	[self setObject: info forKey: key];
	[info release];
}

@end
