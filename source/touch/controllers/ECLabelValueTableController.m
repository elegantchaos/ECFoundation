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
NSString *const kAccessoryKey = @"Accessory";
NSString *const kDefaultsKey = @"Defaults";

// --------------------------------------------------------------------------
//! Return the data for a given section.
// --------------------------------------------------------------------------

- (NSDictionary*) dataForSection: (NSUInteger) section
{
	NSDictionary* data = nil;
	
	if (mData)
	{
		data = [mData objectAtIndex: section];
		
	}
	
	return data;
}

// --------------------------------------------------------------------------
//! Return the rows array for a given section.
// --------------------------------------------------------------------------

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

// --------------------------------------------------------------------------
//! Return the default properties for a given section.
// --------------------------------------------------------------------------

- (NSDictionary*) defaultsForSection: (NSUInteger) section
{
	NSDictionary* defaults = nil;
	
	if (mData)
	{
		NSDictionary* data = [mData objectAtIndex: section];
		if (data)
		{
			defaults = [data valueForKey: kDefaultsKey];
		}
	}
	
	return defaults;
}

// --------------------------------------------------------------------------
//! Return a property of a row, using a default if necessary.
// --------------------------------------------------------------------------

- (id) valueForKey: (NSString*) key inRow: (NSDictionary*) row withDefaults: (NSDictionary*) defaults
{
	id result = [row valueForKey: key];
	if (result == nil)
	{
		result = [defaults valueForKey: key];
	}
	
	return result;
}

// --------------------------------------------------------------------------
//! Return the data for a given path.
// --------------------------------------------------------------------------

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

// --------------------------------------------------------------------------
//! Release references and clean up.
// --------------------------------------------------------------------------

- (void) dealloc 
{
	[mData release];
	
    [super dealloc];
}


#pragma mark UITableViewDataSource methods

// --------------------------------------------------------------------------
//! How many sections are there?
// --------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	NSInteger count = mData.count;

	ECDebug(LabelValueTableChannel, @"number of sections: %d", count);
	
	return count;
}

// --------------------------------------------------------------------------
//! Return the header title for a section.
// --------------------------------------------------------------------------

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSDictionary* data = [self dataForSection: section];
	NSString* result = [data valueForKey: kHeaderKey];

	ECDebug(LabelValueTableChannel, @"header for section %d: %@", section, result);

	return result;
}

// --------------------------------------------------------------------------
//! Return the footer title for a section.
// --------------------------------------------------------------------------

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	NSDictionary* data = [self dataForSection: section];
	NSString* result = [data valueForKey: kFooterKey];

	ECDebug(LabelValueTableChannel, @"footer for section %d: %@", section, result);

	return result;
}

// --------------------------------------------------------------------------
//! Return the number of rows in a section.
// --------------------------------------------------------------------------

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
	
	NSDictionary* defaults = [self defaultsForSection: indexPath.section];
	NSDictionary* row = [self dataForRow: indexPath];
	
	cell.textLabel.text = [self valueForKey: kLabelKey inRow: row withDefaults: defaults];
	cell.detailTextLabel.text = [self valueForKey: kDetailKey inRow: row withDefaults: defaults];
	
	NSNumber* accessory = [self valueForKey: kAccessoryKey inRow: row withDefaults: defaults];
	if (accessory)
	{
		cell.accessoryType = [accessory intValue];
	}
	
	return cell;
}


@end
