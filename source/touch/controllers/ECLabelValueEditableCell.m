// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 31/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECLabelValueEditableCell.h"


@implementation ECLabelValueEditableCell

// --------------------------------------------------------------------------
//! Initialise the cell.
// --------------------------------------------------------------------------

- (id) initForItem: (ECDataItem*) item reuseIdentifier: (NSString*) identifier
{
	if ((self = [super initForItem: item reuseIdentifier: identifier]) != nil)
	{
		
	}
	
	return self;
}

// --------------------------------------------------------------------------
//! Setup the cell.
// --------------------------------------------------------------------------

- (void) setupForItem: (ECDataItem*) item
{
	self.item = item;
	
	[self setupLabel];
	//	[self setupDetail];
	//[self setupAccessory];
}

@end
