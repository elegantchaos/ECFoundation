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

	if (mInitialView)
	{
		mInitialView.title = self.title;
		[self pushViewController: mInitialView animated:FALSE];
	}
	
	ECDebug(ECNavigationControllerChannel, @"loaded");
}

// --------------------------------------------------------------------------
// Store a reference to this nav controller whilst it's in use.
// --------------------------------------------------------------------------

- (void)viewWillAppear:(BOOL)animated
{
	ECDebug(ECNavigationControllerChannel, @"will appear");

	gCurrentController = self;
	[super viewWillAppear:animated];
}

// --------------------------------------------------------------------------
// Clear the reference to this nav controller once it's gone.
// --------------------------------------------------------------------------

- (void)viewWillDisappear:(BOOL)animated
{
	ECDebug(ECNavigationControllerChannel, @"did disappear");
	if (gCurrentController == self)
	{
		gCurrentController = nil;
	}
	
	[super viewWillDisappear:animated];
}

// --------------------------------------------------------------------------
//! We can rotate if the initial view can rotate.
// --------------------------------------------------------------------------

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
	return [mInitialView shouldAutorotateToInterfaceOrientation: interfaceOrientation];
}

// --------------------------------------------------------------------------
//! Release retained objects.
// --------------------------------------------------------------------------

- (void) dealloc
{
	[mInitialView release];
	
	[super dealloc];
}

@end
