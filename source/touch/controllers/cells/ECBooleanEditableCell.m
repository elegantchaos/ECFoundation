// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 28/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECBooleanEditableCell.h"
#import "ECDataItem.h"
#import "UIColor+ECUtilities.h"
#import "ECCellProperties.h"

@implementation ECBooleanEditableCell

ECDefineDebugChannel(BooleanEditableCellChannel);

ECPropertySynthesize(key);

// --------------------------------------------------------------------------
//! Initialise the cell.
// --------------------------------------------------------------------------

- (id) initForItem: (ECDataItem*) item properties: (NSDictionary*) properties reuseIdentifier: (NSString*) identifier
{
	if ((self = [super initWithStyle: UITableViewCellStyleDefault reuseIdentifier: identifier]) != nil)
	{
		UISwitch* control = [[UISwitch alloc] init];
		self.accessoryView = control;
		[control release];

		// which item property should we display the value of?
		self.key = [properties objectForKey: kValueKey];
	}
	
	return self;
}

// --------------------------------------------------------------------------
//! Setup the cell.
// --------------------------------------------------------------------------

- (void) setupForItem: (ECDataItem*) item
{
	[super setupForItem: item];
	
	BOOL value = [item boolForKey: self.key];
	UISwitch* control = (UISwitch*) self.accessoryView;
	control.on = value;
}

@end
