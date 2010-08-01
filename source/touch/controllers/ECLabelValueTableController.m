// --------------------------------------------------------------------------
//! @author sam
//! @date 20/07/2010
//
//  Copyright 2010 sam, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECLabelValueTableController.h"
#import "ECNavigationController.h"
#import "ECDataDrivenView.h"
#import "ECDataItem.h"
#import "ECLabelValueEditableCell.h"
#import "ECLabelValueCell.h"

@implementation ECLabelValueTableController

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

ECPropertySynthesize(data);


// --------------------------------------------------------------------------
//! Release references and clean up.
// --------------------------------------------------------------------------

- (void) dealloc 
{
	ECPropertyDealloc(data);
	
    [super dealloc];
}

- (void) viewDidLoad
{
	// watch for changes on all items
	for (ECDataItem* item in self.data.items)
	{
		[[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(childChanged:) name:DataItemChildChanged object:item];
	}
}

- (void) viewDidUnload
{
	[[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void) childChanged: (NSNotification*) notification
{
	[[self tableView] reloadData];
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
//! Return the header title for a section.
// --------------------------------------------------------------------------

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	ECDataItem* data = [self.data itemAtIndex: section];
	NSString* result = [data objectForKey: kHeaderKey];

	ECDebug(LabelValueTableChannel, @"header for section %d: %@", section, result);

	return result;
}

// --------------------------------------------------------------------------
//! Return the footer title for a section.
// --------------------------------------------------------------------------

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	ECDataItem* data = [self.data itemAtIndex: section];
	NSString* result = [data objectForKey: kFooterKey];

	ECDebug(LabelValueTableChannel, @"footer for section %d: %@", section, result);

	return result;
}

// --------------------------------------------------------------------------
//! Return the number of rows in a section.
// --------------------------------------------------------------------------

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	ECDataItem* data = [self.data itemAtIndex: section];
	NSInteger count = [data.items count];
	
	ECDebug(LabelValueTableChannel, @"number of rows for section %d: %d", section, count);

	return count;
}

// --------------------------------------------------------------------------
//! Return the view for a given row.
// --------------------------------------------------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	ECDataItem* item = [self.data itemAtIndexPath: indexPath];
	Class cellClass = [item boolForKey: kEditableKey] ? [ECLabelValueEditableCell class] : [ECLabelValueCell class];
	NSString* cellIdentifier = NSStringFromClass(cellClass);
	
	UITableViewCell<ECDataDrivenTableCell>* cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
	if (cell == nil)
	{
		cell = [[[cellClass alloc] initForItem: item reuseIdentifier: cellIdentifier] autorelease];
	}
	
	[cell setupForItem: item];
	
	return cell;
}

// --------------------------------------------------------------------------
// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
// --------------------------------------------------------------------------

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
	ECDataItem* item = [self.data itemAtIndexPath: indexPath];
	BOOL result = [item boolForKey: kMoveableKey];
	
	return result;
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

// --------------------------------------------------------------------------
// --------------------------------------------------------------------------

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
	
}



// --------------------------------------------------------------------------
//! Handle selecting a table row.
// --------------------------------------------------------------------------

- (void) tableView:(UITableView*) table didSelectRowAtIndexPath:(NSIndexPath*) path
{
	BOOL subviewOpened = NO;
	ECDataItem* item = [self.data itemAtIndexPath: path];
	
	// open a subview?
	ECNavigationController* navigation = [ECNavigationController currentController];
	if (navigation)
	{
		subviewOpened = [navigation openSubviewForItem: item];
	}

	// reset the selection?
	if (!subviewOpened && ![item boolForKey:kSelectableKey])
	{
		[table deselectRowAtIndexPath: path animated: YES];
	}
}

@end
