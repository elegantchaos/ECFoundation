// --------------------------------------------------------------------------
//! @author Sam Deane
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ModelObject.h"

@implementation ModelObject

@synthesize enabled;
@synthesize label;
@synthesize name;
@synthesize option;

- (void)dealloc
{
    [label release];
    [name release];
    [option release];
    
    [super dealloc];
}

@end
