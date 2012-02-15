// --------------------------------------------------------------------------
//! @author Sam Deane
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ModelObject.h"

@implementation ModelObject

@synthesize name;
@synthesize label;
@synthesize enabled;

- (void)dealloc
{
    [name release];
    [label release];
    
    [super dealloc];
}

@end
