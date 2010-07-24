// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 22/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECTickListTableController.h"
#import "ECLabelValueTableController.h"
#import "ECDataItem.h"

@implementation ECTickListTableController

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

ECPropertySynthesize(data);

// --------------------------------------------------------------------------
// Data Key Constants
// --------------------------------------------------------------------------

static NSString *const kEditButtonEditTitle = @"Edit";
static NSString *const kEditButtonDoneTitle = @"Done";

// --------------------------------------------------------------------------
//! Initialise
// --------------------------------------------------------------------------

- (id) initWithNibName: (NSString*) nibNameOrNil bundle:(NSBundle *)nibBundleOrNil data: (ECDataItem*) data;
{
	if ((nibNameOrNil != nil) || (nibBundleOrNil != nil))
	{
		self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	}
	else
	{
		self = [super initWithStyle: UITableViewStyleGrouped];
	}
	
	if (self != nil)
	{
		self.data = data;
		mSelection = [data valueForKey: kSelectionKey];
		mEditable = [[data valueForKey: kEditableKey] boolValue];
		mMoveable = [[data valueForKey: kMoveableKey] boolValue];
	}
	
	return self;
}

// --------------------------------------------------------------------------
//! Release references and clean up.
// --------------------------------------------------------------------------

- (void) dealloc 
{
	ECPropertyDealloc(data);
	
    [super dealloc];
}


// --------------------------------------------------------------------------
//! Finish setting up the view.
// --------------------------------------------------------------------------

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	if (mEditable)
	{
		UIBarButtonItem* editButton = [[UIBarButtonItem alloc] initWithTitle: kEditButtonEditTitle style: UIBarButtonItemStyleBordered target: self action: @selector(toggleEditing)];
		self.navigationItem.rightBarButtonItem = editButton;
		[editButton release];
	}
}

// --------------------------------------------------------------------------
//! When the view goes away, update the selection property of
//! the data.
// --------------------------------------------------------------------------

- (void) viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear: animated];
	
	[self.data setValue: mSelection forKey: kSelectionKey];
}

// --------------------------------------------------------------------------
//! Toggle editing of a pod.
// --------------------------------------------------------------------------

- (void) toggleEditing
{
	BOOL editingWillBeEnabled = !self.tableView.editing;
	
	self.tableView.editing = editingWillBeEnabled;
	self.navigationItem.rightBarButtonItem.title = editingWillBeEnabled ? kEditButtonDoneTitle : kEditButtonEditTitle;
	self.navigationItem.rightBarButtonItem.style = editingWillBeEnabled ? UIBarButtonItemStyleDone : UIBarButtonItemStyleBordered;
}

#pragma mark UITableViewDataSource methods

// --------------------------------------------------------------------------
//! How many sections are there?
// --------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	
	NSInteger count = self.data.items.count;
	
	ECDebug(LabelValueTableChannel, @"number of sections: %d", count);
	
	return count;
}

// --------------------------------------------------------------------------
//! Return the number of rows in a section.
// --------------------------------------------------------------------------

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	ECDataItem* item = [self.data itemAtIndex: section];
	NSInteger count = [item.items count];
	ECDebug(ECTickListTableControllerChannel, @"number of rows for section %d: %d", section, count);

	return count;
}

// --------------------------------------------------------------------------
//! Return the view for a given row.
// --------------------------------------------------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString* kCellIdentifier = @"ECTickListTableCell";
	
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: kCellIdentifier];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier: kCellIdentifier] autorelease];
	}
	
	ECDataItem* item = [self.data itemAtIndexPath: indexPath];
	cell.textLabel.text = [item objectForKey: kLabelKey];
	cell.accessoryType = (item == mSelection) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	
	return cell;
}

#pragma mark UITableViewDelegate methods

// --------------------------------------------------------------------------
//! Handle selecting a table row.
// --------------------------------------------------------------------------

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	ECDataItem* selectedItem = [self.data itemAtIndexPath: indexPath];
	if (mSelection != selectedItem)
	{
		mSelection = selectedItem;
		[tableView reloadData];
	}
}

// --------------------------------------------------------------------------
//! Return editing style to use for each row.
// --------------------------------------------------------------------------

- (UITableViewCellEditingStyle) tableView:(UITableView*) view editingStlyeForRowAtIndexPath: (NSIndexPath*) path
{
	UITableViewCellEditingStyle style;
	
	style = UITableViewCellEditingStyleDelete;
	
	return style;
}


// --------------------------------------------------------------------------
//! Return whether or not the rows can be moved.
//! Rows in the favourites list can, but in the pods list they can't.
// --------------------------------------------------------------------------

- (BOOL) tableView: (UITableView*) table canEditRowAtIndexPath: (NSIndexPath*) path
{
	return mEditable;
}

// --------------------------------------------------------------------------
//! Return whether or not the rows can be moved.
//! Rows in the favourites list can, but in the pods list they can't.
// --------------------------------------------------------------------------

- (BOOL) tableView: (UITableView*) table canMoveRowAtIndexPath: (NSIndexPath*) path
{
	return mMoveable;
}

// --------------------------------------------------------------------------
//! Change the position of a pod in the favourites list.
// --------------------------------------------------------------------------

- (void) tableView: (UITableView*) table moveRowAtIndexPath: (NSIndexPath*) fromPath toIndexPath: (NSIndexPath*) toPath
{
	//[mPods moveFavouriteFromIndex: fromPath.row toIndex: toPath.row];
}

// --------------------------------------------------------------------------
//! Remove a pod from the favourites list.
// --------------------------------------------------------------------------

- (void) tableView: (UITableView*) table commitEditingStyle: (UITableViewCellEditingStyle) style forRowAtIndexPath: (NSIndexPath*) path
{
	//NSUInteger row = path.row;
	//Pod* pod = [mPods.favourites objectAtIndex: row];
	//[mPods removePodFromFavourites: pod];
	[table deleteRowsAtIndexPaths:[NSArray arrayWithObject: path] withRowAnimation: UITableViewRowAnimationFade];
}


@end
