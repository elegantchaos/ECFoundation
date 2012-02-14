//
//  ECLoggingSampleViewController.m
//  ECLoggingSample
//
//  Created by Sam Deane on 28/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

#import "ECDebugViewController.h"

@interface MainViewController()

@property (nonatomic, retain) ECDebugViewController* debugController;

@end

@implementation MainViewController

#pragma mark - Properties

@synthesize debugController;

- (void)dealloc 
{
    [debugController release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.debugController = [[[ECDebugViewController alloc] initWithNibName:nil bundle:nil] autorelease];
}

- (void)viewDidUnload
{
    self.debugController = nil;
    
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)tappedShowDebugView:(id)sender
{
    [self.navigationController pushViewController:self.debugController animated:YES];
}

@end
