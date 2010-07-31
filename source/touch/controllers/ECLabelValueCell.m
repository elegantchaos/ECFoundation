// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 31/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECLabelValueCell.h"
#import "ECDataItem.h"

@implementation ECLabelValueCell

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

ECPropertySynthesize(item);

// --------------------------------------------------------------------------
//! Initialise with a data item.
// --------------------------------------------------------------------------

- (id) initForItem: (ECDataItem*) item reuseIdentifier: (NSString*) identifier
{
	if ((self = [super initWithStyle: UITableViewCellStyleValue1 reuseIdentifier: identifier]) != nil)
	{
	}
	
	return self;
}

// --------------------------------------------------------------------------
//! Setup the left-hand label.
// --------------------------------------------------------------------------

- (void) setupLabel
{
	self.textLabel.text = [self.item objectForKey: kLabelKey];
}

// --------------------------------------------------------------------------
//! Set up the right-hand detail.
// --------------------------------------------------------------------------

- (void) setupDetail
{
	ECDataItem* item = self.item;
	NSString* detail;
	if ([item boolForKey: kSecureKey])
	{
		detail = @"••••";
	}
	else
	{
		ECDataItem* detailItem = [item objectForKey: kSelectionKey];
		if (!detailItem)
		{
			detailItem = item;
		}
		detail = [detailItem objectForKey: kValueKey];
	}
	
	self.detailTextLabel.text = detail;
}

// --------------------------------------------------------------------------
//! Setup the accessory icon.
// --------------------------------------------------------------------------

- (void) setupAccessory
{
	ECDataItem* item = self.item;
	UITableViewCellAccessoryType accessory = UITableViewCellAccessoryNone;
	NSNumber* accessoryValue = [item objectForKey: kAccessoryKey];
	if (accessoryValue)
	{
		accessory = (UITableViewCellAccessoryType) [accessoryValue intValue];
	}
	else
	{
		BOOL gotViewer = [item objectForKey: kViewerKey] != nil;
		BOOL gotEditor = [item objectForKey: kEditorKey] != nil;
		if (gotViewer && gotEditor)
		{
			accessory = UITableViewCellAccessoryDetailDisclosureButton;
		}
		else if (gotViewer || gotEditor)
		{
			accessory = UITableViewCellAccessoryDisclosureIndicator;
		}
	}
	self.accessoryType = accessory;
}

// --------------------------------------------------------------------------
//! Setup the item.
// --------------------------------------------------------------------------

- (void) setupForItem: (ECDataItem*) item
{
	self.item = item;
	
	[self setupLabel];
	[self setupDetail];
	[self setupAccessory];
}

@end
