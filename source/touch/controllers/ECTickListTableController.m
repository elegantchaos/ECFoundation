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

- (id) initWithNibName: (NSString*) nibNameOrNil bundle:(NSBundle *)nibBundleOrNil data: (NSDictionary*) data defaults: (NSDictionary*) defaults;
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
		[self setData: data defaults: defaults];
	}
	
	return self;
}

// --------------------------------------------------------------------------
//! Set Data
// --------------------------------------------------------------------------

- (void) setData: (NSDictionary*) data defaults: (NSDictionary*) defaults
{
	self.data = data;
	mValues = [[NSMutableArray alloc] init];
	NSMutableArray* section = [[NSMutableArray alloc] init];
	NSArray* values = [data objectForKey: kValuesKey];
	for (NSString* value in values)
	{
		if ([value isEqualToString: @"-"])
		{
			[mValues addObject: section];
			[section release];
			section = [[NSMutableArray alloc] init];
		}
		else
		{
			[section addObject: value];
		}
	}
	[mValues addObject: section];
	[section release];
		
	mSelection = [(NSNumber*) [data valueForKey: kSelectionKey] integerValue];
}

// --------------------------------------------------------------------------
//! Release references and clean up.
// --------------------------------------------------------------------------

- (void) dealloc 
{
	ECPropertyDealloc(data);
	[mValues release];
	
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
//! How many sections are there?
// --------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	NSInteger count = mValues.count;
	
	ECDebug(LabelValueTableChannel, @"number of sections: %d", count);
	
	return count;
}

// --------------------------------------------------------------------------
//! Return the number of rows in a section.
// --------------------------------------------------------------------------

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	NSArray* values = [mValues objectAtIndex: section];
	NSInteger count = [values count];
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
	
	NSArray* sectionValues = [mValues objectAtIndex: indexPath.section];
	cell.textLabel.text = [sectionValues objectAtIndex: indexPath.row];
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
