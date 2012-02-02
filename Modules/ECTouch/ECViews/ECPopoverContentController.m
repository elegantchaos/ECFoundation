// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 02/02/2012
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECPopoverContentController.h"

@implementation ECPopoverContentControllerBase

@synthesize popover;

- (void)dealloc
{
    [popover release];
    
    [super dealloc];
}

@end

@implementation ECPopoverContentControllerTable

@synthesize popover;

- (void)dealloc
{
    [popover release];
    
    [super dealloc];
}

@end
