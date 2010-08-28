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
		
		[control addTarget: self action: @selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
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

// --------------------------------------------------------------------------
//! Respond to the user changing value of the switch.
// --------------------------------------------------------------------------

 - (void) valueChanged: (id) sender
 {
	 UISwitch* control = (UISwitch*) self.accessoryView;
	 BOOL value = control.isOn;
	[self.item setBoolean: value forKey: self.key];
	[self.item postChangedNotifications];
 }

@end
