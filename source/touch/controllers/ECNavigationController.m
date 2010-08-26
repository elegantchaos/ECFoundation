// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 21/07/2010.
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECNavigationController.h"
#import "ECDataItem.h"
#import "ECDataDrivenView.h"

ECDefineDebugChannel(ECNavigationControllerChannel);

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

// --------------------------------------------------------------------------
//! Return the controller that's currently visible.
// --------------------------------------------------------------------------

+ (ECNavigationController*) currentController
{
	return gCurrentController;
}

// --------------------------------------------------------------------------
//! Open an editor or viewer subview for the item.
//! If the item has both defined, we use the editor.
// --------------------------------------------------------------------------

- (BOOL) openSubviewForItem: (ECDataItem*) item
{
	BOOL opened = NO;
	
	if ([item objectForKey: kEditorKey] != nil)
	{
		opened = [self openEditorForItem: item];
	}
	
	if (!opened)
	{
		opened = [self openViewerForItem: item];
	}
	
	return opened;
}

// --------------------------------------------------------------------------
//! Open the default viewer controller for the given item, and push it into the 
//! navigation stack as the current controller.
// --------------------------------------------------------------------------

- (BOOL) openViewerForItem: (ECDataItem*) item
{
	return [self openViewForItem: item classKey: kViewerKey nibKey: kViewerNibKey];
}

// --------------------------------------------------------------------------
//! Open the default editor controller for the given item, and push it into the 
//! navigation stack as the current controller.
// --------------------------------------------------------------------------

- (BOOL) openEditorForItem: (ECDataItem*) item
{
	return [self openViewForItem: item classKey: kEditorKey nibKey: kEditorNibKey];
}

// --------------------------------------------------------------------------
//! Open the specified view controller for the given item, and push it into the 
//! navigation stack as the current controller.
// --------------------------------------------------------------------------

- (BOOL) openViewForItem: (ECDataItem*) item classKey: (NSString*) classKey nibKey: (NSString*) nibKey
{
	BOOL opened = NO;
	
	Class class = [item objectForKey: classKey];
	if ([class isSubclassOfClass: [UIViewController class]])
	{
		NSString* nib = [item objectForKey: nibKey];
		UIViewController* controller;
		if ([class conformsToProtocol: @protocol(ECDataDrivenView)])
		{
			controller = [((id<ECDataDrivenView>) [class alloc]) initWithNibName: nib bundle: nil data: item];
		}
		else
		{
			controller = [[class alloc] initWithNibName: nib bundle: nil];
		}
		
		[self pushViewController: controller animated:TRUE];
		[controller release];
		opened = YES;
	}
	else
	{
		if (class)
		{
			ECDebug(ECNavigationControllerChannel, @"%@ class %@ for item %@ is not a UIViewController", classKey, item, class);
		}
		else
		{
			ECDebug(ECNavigationControllerChannel, @"%@ class not set for item %@", classKey, item);
		}

	}

	return opened;
}
@end
