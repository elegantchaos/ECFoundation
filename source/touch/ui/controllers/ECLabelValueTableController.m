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
#import "ECCellProperties.h"

@implementation ECLabelValueTableController

ECDefineDebugChannel(LabelValueTableChannel);

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

ECPropertySynthesize(data);
ECPropertySynthesize(cellClass);

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
	}
	
	return self;
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
//! Finish setting up the view.
// --------------------------------------------------------------------------

- (void) viewDidLoad
{
	// watch for changes on all items
	[[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(childChanged:) name:DataItemChildChanged object:self.data];
	for (ECDataItem* item in self.data.items)
	{
		[[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(childChanged:) name:DataItemChildChanged object:item];
	}
}

// --------------------------------------------------------------------------
//! Clean up view.
// --------------------------------------------------------------------------

- (void) viewDidUnload
{
	[[NSNotificationCenter defaultCenter] removeObserver: self];
}

// --------------------------------------------------------------------------
//! Make sure that the item links are consistent.
// --------------------------------------------------------------------------

- (void)viewWillAppear:(BOOL)animated
{
	[self.data updateParentLinks];
	[super viewWillAppear:animated];
}

// --------------------------------------------------------------------------
//! Mark the table for reload in case any contents are changed
//! whilst we're hidden.
// --------------------------------------------------------------------------

- (void)viewWillDisappear:(BOOL)animated
{
	[self.tableView reloadData];
	[super viewWillDisappear:animated];
}

- (void) childChanged: (NSNotification*) notification
{
	UITableView* table = [self tableView];
	if (table)
	{
		[table reloadData];
	}
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


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView* view = nil;
	
	ECDataItem* data = [self.data itemAtIndex: section];
	NSString* font = [data objectForKey: kLabelFontKey];
	NSNumber* sizeValue = [data objectForKey: kLabelSizeKey];
	if (font || sizeValue)
	{
		CGRect rect = CGRectZero;
		rect.origin.x = 20;
		rect.size.width = tableView.bounds.size.width - 20;
		rect.size.height = 44;
		
		view = [[[UIView alloc] initWithFrame: rect] autorelease];
		NSString* title = [data objectForKey: kHeaderKey];
		UILabel* label = [[UILabel alloc] initWithFrame: rect];
		label.text = title;
		CGFloat size;
		if (sizeValue)
		{
			size = [sizeValue floatValue];
		}
		else
		{
			size = label.font.pointSize;
		}

		UIFont* newFont;
		if (font)
		{
			newFont = [UIFont fontWithName: font size: size];
		}
		else
		{
			newFont = [label.font fontWithSize: size];
		}

		label.font = newFont;
		label.opaque = NO;
		label.backgroundColor = [UIColor clearColor];
		
		[view addSubview: label];
		[label release];
	}
	
	return view;
}

// --------------------------------------------------------------------------
//! Return custom height for table header.
// --------------------------------------------------------------------------

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	CGFloat height = 44;
	
	ECDataItem* data = [self.data itemAtIndex: section];
	NSString* font = [data objectForKey: kLabelFontKey];
	NSNumber* sizeValue = [data objectForKey: kLabelSizeKey];
	if (font || sizeValue)
	{
		height = 44;
	}
	
	return height;
}

// --------------------------------------------------------------------------
//! Return the header title for a section.
// --------------------------------------------------------------------------

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	ECDataItem* data = [self.data itemAtIndex: section];
	NSString* result = [data objectForKey: kHeaderKey];
	if (result)
	{
		ECDebug(LabelValueTableChannel, @"header for section %d: %@", section, result);
	}

	return result;
}

// --------------------------------------------------------------------------
//! Return the footer title for a section.
// --------------------------------------------------------------------------

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	ECDataItem* data = [self.data itemAtIndex: section];
	NSString* result = [data objectForKey: kFooterKey];

	if (result)
	{
		ECDebug(LabelValueTableChannel, @"footer for section %d: %@", section, result);
	}

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	ECDataItem* item = [self.data itemAtIndexPath: indexPath];
	NSNumber* value = [item objectForKey: kRowHeightKey];
	CGFloat height = value ? [value floatValue] : tableView.rowHeight;
	
	return height;
}

// --------------------------------------------------------------------------
//! Return the view for a given row.
// --------------------------------------------------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	ECDataItem* item = [self.data itemAtIndexPath: indexPath];
	Class cellClass = [item objectForKey: kCellClassKey];
	if (!cellClass)
	{
		cellClass = [ECLabelValueCell class];
	}
	NSDictionary* cellProperties = [item objectForKey: kCellPropertiesKey];
	NSString* cellIdentifier = NSStringFromClass(cellClass);
	
	UITableViewCell<ECDataDrivenTableCell>* cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
	if (cell == nil)
	{
		cell = [[[cellClass alloc] initForItem: item properties: cellProperties reuseIdentifier: cellIdentifier] autorelease];
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
	
	// open a subview for the item?
	ECNavigationController* navigation = [ECNavigationController currentController];
	if (navigation)
	{
		subviewOpened = [navigation openSubviewForItem: item];
	}

	// select the item?
	if (!subviewOpened)
	{
		[item postSelectedNotification];
	}
	
	// reset the hilight on the item?
	if (!subviewOpened && ![item boolForKey:kSelectableKey])
	{
		[table deselectRowAtIndexPath: path animated: YES];
	}
}

@end
