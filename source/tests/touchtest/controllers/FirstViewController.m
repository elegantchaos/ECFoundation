// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 01/08/2010
//
//  Copyright 2010 sam, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "FirstViewController.h"
#import "TouchTestAppDelegate.h"
#import <ECFoundation/ECTickListTableController.h>

@implementation FirstViewController

// --------------------------------------------------------------------------
//! Set up the view.
// --------------------------------------------------------------------------

- (void)viewDidLoad 
{
	// make some test data to display/edit
	TouchTestAppDelegate* app = [UIApplication sharedApplication].delegate;
	
	ECDataItem* data = [ECDataItem item];
	ECDataItem* section1 = [ECDataItem item];
	[section1 addItem: app.name];
	[section1 addItem: app.password];
	[section1 addItem: [ECDataItem itemWithObjectsAndKeys: @"Description", kLabelKey, @"Blah blah, blah de blah", kValueKey, nil]];
	[section1 setObject: @"Editable Section" forKey: kHeaderKey];
	[section1 setBooleanDefault: YES forKey: kEditableKey];
	[data addItem: section1];

	ECDataItem* section2 = [ECDataItem itemWithItemsWithKey: kLabelKey andValues: @"four", @"five", @"six", nil];
	[section2 setObject: @"Selectable Section" forKey: kHeaderKey];
	[section2 setBooleanDefault: YES forKey: kSelectableKey];
	[data addItem: section2];

	ECDataItem* section3 = [ECDataItem item];
	ECDataItem* tickableItem = [ECDataItem itemWithObjectsAndKeys: @"Tickable Items",kLabelKey, [ECTickListTableController class], kEditorKey, nil];
	ECDataItem* subsection1 = [ECDataItem itemWithItemsWithKey: kValueKey andValues: @"scooby", @"dooby", @"doo", nil];
	[tickableItem addItem: subsection1];
	[tickableItem selectItemAtIndex: 0 inSection: 0];
	[section3 addItem: tickableItem];
	[section3 setObject: @"Subview Section" forKey: kHeaderKey];
	[data addItem: section3];

	self.data = data;
	
    [super viewDidLoad];
}

// --------------------------------------------------------------------------
//! Deal with low memory.
// --------------------------------------------------------------------------

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

// --------------------------------------------------------------------------
//! Release retained data.
// --------------------------------------------------------------------------

- (void)dealloc 
{
    [super dealloc];
}

@end
