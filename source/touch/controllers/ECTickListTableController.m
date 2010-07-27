// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 22/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECTickListTableController.h"
#import "ECLabelValueTableController.h"
#import "ECDataItem.h"
#import "ECNavigationController.h"

// --------------------------------------------------------------------------
// Internal Methods
// --------------------------------------------------------------------------

@interface ECTickListTableController()
@end


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
		self.title = [data objectForKey: kLabelKey];
		mSelection = [data objectForKey: kSelectionKey];
		mEditable = [[data objectForKey: kEditableKey] boolValue];
	}
	
	return self;
}

// --------------------------------------------------------------------------
//! Release references and clean up.
// --------------------------------------------------------------------------

- (void) dealloc 
{
	ECPropertyDealloc(data);
	
	[mAddButton release];
	
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
		
		mAddButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
	}
}

// --------------------------------------------------------------------------
//! When the view goes away, update the selection property of
//! the data.
// --------------------------------------------------------------------------

- (void) viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear: animated];
	
	[self.data setObject: mSelection ? mSelection : [NSNull null] forKey: kSelectionKey];
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
	self.navigationItem.leftBarButtonItem = editingWillBeEnabled ? mAddButton : nil;
}


#pragma mark UITableViewDataSource methods

// --------------------------------------------------------------------------
//! How many sections are there?
// --------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView: (UITableView*) view
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

- (UITableViewCell *)tableView: (UITableView*) view cellForRowAtIndexPath: (NSIndexPath*) path
{
	static NSString* kCellIdentifier = @"ECTickListTableCell";
	
	UITableViewCell* cell = [view dequeueReusableCellWithIdentifier: kCellIdentifier];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier: kCellIdentifier] autorelease];
	}
	
	ECDataItem* item = [self.data itemAtIndexPath: path];
	cell.textLabel.text = [item objectForKey: kValueKey];
	cell.accessoryType = (item == mSelection) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	cell.editingAccessoryType = ([[item objectForKey: kEditableKey] boolValue]) ? UITableViewCellAccessoryDetailDisclosureButton : UITableViewCellAccessoryNone;

	return cell;
}

#pragma mark UITableViewDelegate methods

// --------------------------------------------------------------------------
//! Handle selecting a table row.
// --------------------------------------------------------------------------

- (void) tableView: (UITableView*) view didSelectRowAtIndexPath: (NSIndexPath*) path
{
	ECDataItem* selectedItem = [self.data itemAtIndexPath: path];
	if (mSelection != selectedItem)
	{
		mSelection = selectedItem;
		[view reloadData];
	}
}

// --------------------------------------------------------------------------
//! Handle a tap on the accessory button.
// --------------------------------------------------------------------------

- (void) tableView: (UITableView*) view accessoryButtonTappedForRowWithIndexPath: (NSIndexPath*) path
{
	ECDataItem* item = [self.data itemAtIndexPath: path];
	ECNavigationController* navigation = [ECNavigationController currentController];
	[navigation openEditorForItem: item];
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
	ECDataItem* item = [self.data itemAtIndexPath: path];
	return [[item objectForKey: kEditableKey] boolValue];
}

// --------------------------------------------------------------------------
//! Return whether or not the rows can be moved.
//! Rows in the favourites list can, but in the pods list they can't.
// --------------------------------------------------------------------------

- (BOOL) tableView: (UITableView*) table canMoveRowAtIndexPath: (NSIndexPath*) path
{
	ECDataItem* item = [self.data itemAtIndexPath: path];
	return [[item objectForKey: kMoveableKey] boolValue];
}

// --------------------------------------------------------------------------
//! Restrict movement of items so that they stay within their own sections.
// --------------------------------------------------------------------------

- (NSIndexPath *)tableView: (UITableView*) view targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
	NSIndexPath* result;
	NSUInteger sourceSection = sourceIndexPath.section;
	NSUInteger proposedSection = proposedDestinationIndexPath.section;
	
	if (sourceSection == proposedSection)
	{
		result = proposedDestinationIndexPath;
	}
	else
	{
		NSUInteger row;
		if (sourceSection < proposedSection)
		{
			ECDataItem* sectionData = [self.data itemAtIndex: sourceSection];
			row = [sectionData.items count];
		}
		else
		{
			row = 0;
		}
		
		result = [NSIndexPath indexPathForRow: row inSection: sourceIndexPath.section];
	}
	
	return result;
}

// --------------------------------------------------------------------------
//! Change the position of a pod in the favourites list.
// --------------------------------------------------------------------------

- (void) tableView: (UITableView*) table moveRowAtIndexPath: (NSIndexPath*) fromPath toIndexPath: (NSIndexPath*) toPath
{
	[self.data moveItemFromIndexPath: fromPath toIndexPath: toPath];
}

// --------------------------------------------------------------------------
//! Remove a pod from the favourites list.
// --------------------------------------------------------------------------

- (void) tableView: (UITableView*) table commitEditingStyle: (UITableViewCellEditingStyle) style forRowAtIndexPath: (NSIndexPath*) path
{
	[self.data removeItemAtIndexPath: path];
	[table deleteRowsAtIndexPaths:[NSArray arrayWithObject: path] withRowAnimation: UITableViewRowAnimationFade];
}


@end
