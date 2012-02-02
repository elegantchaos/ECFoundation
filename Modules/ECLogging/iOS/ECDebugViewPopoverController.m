// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 02/02/2012
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECDebugViewPopoverController.h"
#import "ECDebugViewController.h"

@interface ECDebugViewPopoverController ()

@property (strong, nonatomic) UINavigationController* navController;

@end

@implementation ECDebugViewPopoverController

@synthesize navController;

- (void)dealloc
{
    [navController release];
    
    [super dealloc];
}

- (void)loadView
{
    CGRect frame = CGRectMake(0, 0, 600, 800);
    UIView* root = [[UIView alloc] initWithFrame:frame];
    
    // Implement loadView to create a view hierarchy programmatically, without using a nib.
    ECDebugViewController* dc = [[ECDebugViewController alloc] init];
    UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:dc];
    self.navController = nc;
    dc.view.frame = frame;
    nc.view.frame = frame;
    [root addSubview:nc.view];
    [nc release];
    [dc release];
    
    self.view = root;
    [root release];
}

@end
