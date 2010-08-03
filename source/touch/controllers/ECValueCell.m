// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 31/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECValueCell.h"
#import "ECDataItem.h"

@implementation ECValueCell

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

ECPropertySynthesize(item);

// --------------------------------------------------------------------------
//! Initialise with a data item.
// --------------------------------------------------------------------------

- (id) initForItem: (ECDataItem*) item reuseIdentifier: (NSString*) identifier
{
	if ((self = [super initWithStyle: UITableViewCellStyleDefault reuseIdentifier: identifier]) != nil)
	{
	}
	
	return self;
}

// --------------------------------------------------------------------------
//! Setup the item.
// --------------------------------------------------------------------------

- (void) setupForItem: (ECDataItem*) item
{
	self.item = item;
	self.textLabel.text = [item objectForKey: kValueKey];
}

@end
