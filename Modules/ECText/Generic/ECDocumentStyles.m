// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/10/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECDocumentStyles.h"

@implementation ECDocumentStyles

@synthesize boldFont;
@synthesize colour;
@synthesize linkColour;
@synthesize headingFont;
@synthesize headingSize;
@synthesize italicFont;
@synthesize plainFont;
@synthesize plainSize;

- (void)dealloc
{
    [boldFont release];
    [headingFont release];
	[italicFont release];
    [plainFont release];
    
    [super dealloc];
}

@end
