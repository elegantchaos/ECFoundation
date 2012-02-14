// --------------------------------------------------------------------------
//! @author Sam Deane
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "MainViewController.h"

#import "ECPopoverBarButtonItem.h"
#import "ECTSectionDrivenTableController.h"

@interface MainViewController()

@end

@implementation MainViewController

#pragma mark - Properties

@synthesize table;

#pragma mark - Object Lifecycle

- (void)dealloc 
{
    [table release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem* debugButton = [[ECPopoverBarButtonItem alloc] initWithTitle:@"Debug" style:UIBarButtonItemStylePlain content:@"ECDebugViewPopoverController"];
    self.navigationItem.rightBarButtonItem = debugButton;
    [debugButton release];
}

- (void)viewDidUnload
{   
    self.table = nil;
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
