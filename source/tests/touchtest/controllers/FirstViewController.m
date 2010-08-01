//
//  FirstViewController.m
//  ECFoundation TouchTest
//
//  Created by Sam Deane on 01/08/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//

#import "FirstViewController.h"

#import <ECFoundation/ECTickListTableController.h>

@implementation FirstViewController


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	// make some test data to display/edit
	
	ECDataItem* data = [ECDataItem item];
	ECDataItem* section1 = [ECDataItem itemWithItemsWithKey: kLabelKey andValues: @"one", @"two", @"three", nil];
	for (ECDataItem* item in section1.items)
	{
		[item setObject: @"doodah" forKey:kValueKey];
	}
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

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
