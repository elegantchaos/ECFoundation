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

// --------------------------------------------------------------------------
//! Initialise
// --------------------------------------------------------------------------

- (void) setData: (NSDictionary*) data defaults: (NSDictionary*) defaults
{
	self.data = data;
	mValues = [data objectForKey: kValuesKey];
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
	
	return cell;
}



// --------------------------------------------------------------------------
//! Handle selecting a table row.
// --------------------------------------------------------------------------

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	/*
	ECSubviewInfo* info = [self valueForKey: kSubviewKey atPath: indexPath];
	if (info)
	{
		UIViewController* controller = [[info.classToUse alloc] initWithNibName: info.nib bundle: nil];
		ECNavigationController* navigation = [ECNavigationController currentController];
		[navigation pushViewController: controller animated:TRUE];
	 
	}
	 */
}

@end
