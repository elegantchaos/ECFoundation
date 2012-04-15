// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 07/03/2010
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECPreferencePanel.h"


@implementation ECPreferencePanel

- (NSView *)paneView
{
    BOOL loaded = YES;
    
    if (!prefsView) 
	{
        loaded = [NSBundle loadNibNamed:@"view" owner:self];
    }
    
    if (loaded) 
	{
		[self paneDidLoad];
        return prefsView;
    }
    
    return nil;
}

- (NSImage *)paneIcon
{
    return [[[NSImage alloc] initWithContentsOfFile:
			 [[NSBundle bundleForClass:[self class]] pathForImageResource:@"icon"]
			 ] autorelease];
}

- (BOOL)allowsHorizontalResizing
{
    return NO;
}


- (BOOL)allowsVerticalResizing
{
    return NO;
}

- (void) paneDidLoad
{
	
}

- (NSString*) paneName
{
	NSString* name = [[NSBundle bundleForClass:[self class]] objectForInfoDictionaryKey: @"CFBundleName"];
	
    return name;
}

// --------------------------------------------------------------------------
// These methods must be overriden by the subclasses
// --------------------------------------------------------------------------

+ (NSArray*) preferencePanes
{
    return nil;
}


- (NSString*) paneToolTip
{
    return @"";
}
@end
