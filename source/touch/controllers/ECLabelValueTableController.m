// --------------------------------------------------------------------------
//! @author sam
//! @date 20/07/2010
//
//  Copyright 2010 sam, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECLabelValueTableController.h"

@implementation ECLabelValueTableController

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------


@synthesize data = mData;

// --------------------------------------------------------------------------
// Data Key Constants
// --------------------------------------------------------------------------

NSString *const kHeaderKey = @"Header";
NSString *const kFooterKey = @"Footer";
NSString *const kRowsKey = @"Rows";
NSString *const kLabelKey = @"Label";
NSString *const kDetailKey = @"Detail";



// --------------------------------------------------------------------------
//! Release references and clean up.
// --------------------------------------------------------------------------

- (void) dealloc 
{
	[mData release];
	
    [super dealloc];
}


#pragma mark UITableViewDataSource methods

- (NSDictionary*) dataForSection: (NSUInteger) section
{
	NSDictionary* data = nil;
	
	if (mData)
	{
		data = [mData objectAtIndex: section];
		
	}
	
	return data;
}

- (NSArray*) rowsForSection: (NSUInteger) section
{
	NSArray* rows = nil;
	
	if (mData)
	{
		NSDictionary* data = [mData objectAtIndex: section];
		if (data)
		{
			rows = [data valueForKey: kRowsKey];
		}
	}
	
	return rows;
}

- (NSDictionary*) dataForRow: (NSIndexPath*) path
{
	NSDictionary* row = nil;
	NSArray* rows = [self rowsForSection: path.section];
	if (rows)
	{
		row = [rows objectAtIndex: path.row];
	}
	return row;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	NSInteger count = mData.count;

	ECDebug(LabelValueTableChannel, @"number of sections: %d", count);
	
	return count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSDictionary* data = [self dataForSection: section];
	NSString* result = [data valueForKey: kHeaderKey];

	ECDebug(LabelValueTableChannel, @"header for section %d: %@", section, result);

	return result;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	NSDictionary* data = [self dataForSection: section];
	NSString* result = [data valueForKey: kFooterKey];

	ECDebug(LabelValueTableChannel, @"footer for section %d: %@", section, result);

	return result;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	NSArray* rows = [self rowsForSection: section];
	NSInteger count = [rows count];
	
	ECDebug(LabelValueTableChannel, @"number of rows for section %d: %d", section, count);

	return count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString* kCellIdentifier = @"ECLabelValueCell";
	
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: kCellIdentifier];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier: kCellIdentifier] autorelease];
	}
	
	NSDictionary* row = [self dataForRow: indexPath];
	cell.textLabel.text = [row objectForKey: kLabelKey];
	cell.detailTextLabel.text = [row objectForKey: kDetailKey];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}


@end
