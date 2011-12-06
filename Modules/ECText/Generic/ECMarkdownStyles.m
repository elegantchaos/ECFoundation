// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/10/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECMarkdownStyles.h"

@implementation ECMarkdownStyles

@synthesize boldFont;
@synthesize colour;
@synthesize headingFont;
@synthesize headingSize;
@synthesize plainFont;
@synthesize plainSize;

- (void)dealloc
{
    [boldFont release];
    [headingFont release];
    [plainFont release];
    
    [super dealloc];
}

@end
