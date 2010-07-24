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
	static NSString* kCellIdentifier = @"ECLabelValueCell";
	
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: kCellIdentifier];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier: kCellIdentifier] autorelease];
	}
	
	ECDataItem* item = [self.data itemAtIndexPath: indexPath];

	cell.textLabel.text = [item objectForKey: kLabelKey];
	cell.detailTextLabel.text = [item objectForKey: kDetailKey];
	
	NSNumber* accessory = [item objectForKey: kAccessoryKey];
	if (accessory)
	{
		cell.accessoryType = [accessory intValue];
	}
	
	return cell;
}

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
	ECDataItem* item = [self.data itemAtIndexPath: indexPath];
	BOOL result = [[item objectForKey: kMoveableKey] boolValue];
	
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
	ECDataItem* item = [self.data itemAtIndexPath: indexPath];
	Class class = [item objectForKey: kSubviewKey];
	if ([class isSubclassOfClass: [UIViewController class]])
	{
		NSString* nib = [item objectForKey: kSubviewNibKey];
		UIViewController* controller;
		if ([class conformsToProtocol: @protocol(ECDataDrivenView)])
		{
			controller = [((id<ECDataDrivenView>) [class alloc]) initWithNibName: nib bundle: nil data: item];
		}
		else
		{
			controller = [[class alloc] initWithNibName: nib bundle: nil];
		}

		controller.title = [item objectForKey: kLabelKey];

		ECNavigationController* navigation = [ECNavigationController currentController];
		[navigation pushViewController: controller animated:TRUE];
		[controller release];
		
	}
	else
	{
		ECDebug(ECLabelValueTableChannel, @"Class %@ is not a UIViewController", class);
	}
}

@end
