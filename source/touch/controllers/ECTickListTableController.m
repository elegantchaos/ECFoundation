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
	cell.editingAccessoryType = ([item boolForKey: kEditableKey]) ? UITableViewCellAccessoryDetailDisclosureButton : UITableViewCellAccessoryNone;

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
		[self.data selectItemAtIndexPath: path];
		[view reloadData];
	}
}


@end
