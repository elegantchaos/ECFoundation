// --------------------------------------------------------------------------
//! @author sam
//! @date 20/07/2010
//
//  Copyright 2010 sam, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECLabelValueTableController.h"
#import "ECSubviewInfo.h"
#import "ECNavigationController.h"
#import "ECDataDrivenView.h"
#import "ECDataItem.h"

@implementation ECLabelValueTableController

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

ECPropertySynthesize(data);


// --------------------------------------------------------------------------
//! Return the data for a given section.
// --------------------------------------------------------------------------

- (NSDictionary*) dataForSection: (NSUInteger) section
{
	NSDictionary* data = [self.data objectAtIndex: section];
		
	return data;
}

// --------------------------------------------------------------------------
//! Return the rows array for a given section.
// --------------------------------------------------------------------------

- (NSArray*) rowsForSection: (NSUInteger) section
{
	NSArray* rows = nil;
	NSDictionary* data = [self.data objectAtIndex: section];
	if (data)
	{
		rows = [data valueForKey: kItemsKey];
	}
	
	return rows;
}

// --------------------------------------------------------------------------
//! Return the default properties for a given section.
// --------------------------------------------------------------------------

- (NSDictionary*) defaultsForSection: (NSUInteger) section
{
	NSDictionary* defaults = nil;
	
	NSDictionary* data = [self.data objectAtIndex: section];
	if (data)
	{
		defaults = [data valueForKey: kDefaultsKey];
	}
	
	return defaults;
}

// --------------------------------------------------------------------------
//! Return the data for a given path.
// --------------------------------------------------------------------------

- (NSDictionary*) dataForPath: (NSIndexPath*) path
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
//! Return a property for a given path.
// --------------------------------------------------------------------------

- (id) valueForKey: (NSString*) key atPath: (NSIndexPath*) path
{
	NSInteger section = path.section;
	if ((mCachedDefaults == nil) || (section != mCachedSection))
	{
		mCachedSection = section;
		mCachedDefaults = [self defaultsForSection: section];
		mCachedRow = -1;
	}
	
	NSInteger row = path.row;
	if ((mCachedRowData == nil) || (row != mCachedRow))
	{
		mCachedRowData = [self dataForPath: path];
		mCachedRow = row;
	}
	
	id result = [self valueForKey: key inRow: mCachedRowData withDefaults: mCachedDefaults];
	
	return result;
}


// --------------------------------------------------------------------------
//! Release references and clean up.
// --------------------------------------------------------------------------

- (void) dealloc 
{
	ECPropertyDealloc(data);
	
    [super dealloc];
}


#pragma mark UITableViewDataSource methods

// --------------------------------------------------------------------------
//! How many sections are there?
// --------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	NSInteger count = self.data.count;

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

// --------------------------------------------------------------------------
//! Return the view for a given row.
// --------------------------------------------------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString* kCellIdentifier = @"ECLabelValueCell";
	
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: kCellIdentifier];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier: kCellIdentifier] autorelease];
	}
	
	cell.textLabel.text = [self valueForKey: kLabelKey atPath: indexPath];
	cell.detailTextLabel.text = [self valueForKey: kDetailKey atPath: indexPath];
	
	NSNumber* accessory = [self valueForKey: kAccessoryKey atPath: indexPath];
	if (accessory)
	{
		cell.accessoryType = [accessory intValue];
	}
	
	return cell;
}

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
	BOOL result = [[self valueForKey: kMoveableKey  atPath: indexPath] boolValue];
	
	return result;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
	
}



// --------------------------------------------------------------------------
//! Handle selecting a table row.
// --------------------------------------------------------------------------

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	ECSubviewInfo* info = [self valueForKey: kSubviewKey atPath: indexPath];
	if (info)
	{
		Class class = info.classToUse;
		if ([class isSubclassOfClass: [UIViewController class]])
		{
			UIViewController* controller;
			if ([class conformsToProtocol: @protocol(ECDataDrivenView)])
			{
				NSDictionary* row = [self dataForPath: indexPath];
				NSDictionary* defaults = [self defaultsForSection: indexPath.section];
				controller = [((id<ECDataDrivenView>) [class alloc]) initWithNibName: info.nib bundle: nil data: row defaults: defaults];
			}
			else
			{
				controller = [[class alloc] initWithNibName: info.nib bundle: nil];
			}

			controller.title = [self valueForKey: kLabelKey atPath: indexPath];

			ECNavigationController* navigation = [ECNavigationController currentController];
			[navigation pushViewController: controller animated:TRUE];
			[controller release];
			
		}
		else
		{
			ECDebug(ECLabelValueTableChannel, @"Class %@ is not a UIViewController", class);
		}
	}
}

@end
