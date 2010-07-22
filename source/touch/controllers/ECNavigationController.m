// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 21/07/2010.
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECNavigationController.h"

@implementation ECNavigationController

static ECNavigationController* gCurrentController = nil;


@synthesize initialView = mInitialView;

// --------------------------------------------------------------------------
//! Finish setting up the view.
// --------------------------------------------------------------------------

- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	ECDebug(PodListNavigationChannel, @"xx nav did load");

}

// --------------------------------------------------------------------------
// Store a reference to this nav controller whilst it's in use.
// --------------------------------------------------------------------------

- (void)viewWillAppear:(BOOL)animated
{
	ECDebug(PodListNavigationChannel, @"xx nav will appear");
	gCurrentController = self;

	if (mInitialView)
	{
		mInitialView.title = self.title;
		[self pushViewController: mInitialView animated:FALSE];
	}
	
	[super viewWillAppear:animated];
}

// --------------------------------------------------------------------------
// Clear the reference to this nav controller once it's gone.
// --------------------------------------------------------------------------

- (void)viewWillDisappear:(BOOL)animated
{
	ECDebug(PodListNavigationChannel, @"nav did disappear");
	if (gCurrentController == self)
	{
		gCurrentController = nil;
	}
	
	[super viewWillDisappear:animated];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
	return YES;
}

// --------------------------------------------------------------------------
//! Release retained objects.
// --------------------------------------------------------------------------

- (void) dealloc
{
	[super dealloc];
}

@end
