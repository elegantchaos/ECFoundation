// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 22/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECTickListTableController.h"

@implementation ECTickListTableController

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

ECPropertySynthesize(data);

// --------------------------------------------------------------------------
// Data Key Constants
// --------------------------------------------------------------------------

NSString *const kValuesKey = @"Values";
NSString *const kSelectionKey = @"Selection";

// --------------------------------------------------------------------------
//! Initialise
// --------------------------------------------------------------------------

- (void) setData: (NSDictionary*) data defaults: (NSDictionary*) defaults
{
	self.data = data;
	mValues = [data objectForKey: kValuesKey];
	mSelection = [(NSNumber*) [data valueForKey: kSelectionKey] integerValue];
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
//! When the view goes away, update the selection property of
//! the data.
// --------------------------------------------------------------------------

- (void) viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear: animated];
	
	[self.data setValue: [NSNumber numberWithInt: mSelection] forKey: kSelectionKey];
}


#pragma mark UITableViewDataSource methods

// --------------------------------------------------------------------------
//! Return the number of rows in a section.
// --------------------------------------------------------------------------

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	NSInteger count = [mValues count];
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
	
	cell.textLabel.text = [mValues objectAtIndex: indexPath.row];
	cell.accessoryType = (indexPath.row == mSelection) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	
	return cell;
}

#pragma mark UITableViewDelegate methods

// --------------------------------------------------------------------------
//! Handle selecting a table row.
// --------------------------------------------------------------------------

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (mSelection != indexPath.row)
	{
		mSelection = indexPath.row;
		[tableView reloadData];
	}
}

@end
