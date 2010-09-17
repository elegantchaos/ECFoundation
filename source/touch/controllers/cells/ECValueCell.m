// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 31/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECValueCell.h"
#import "ECDataItem.h"
#import "ECCellProperties.h"

@implementation ECValueCell

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

ECPropertySynthesize(item);

// --------------------------------------------------------------------------
//! Initialise with a data item.
// --------------------------------------------------------------------------

- (id) initForItem: (ECDataItem*) item properties: (NSDictionary*) properties reuseIdentifier: (NSString*) identifier
{
	if ((self = [super initWithStyle: UITableViewCellStyleDefault reuseIdentifier: identifier]) != nil)
	{
	}
	
	return self;
}

// --------------------------------------------------------------------------
//! Setup the style of the label.
// --------------------------------------------------------------------------

- (void) setupStyleOfLabel: (UILabel*) label fontKey: (NSString*) fontKey sizeKey: (NSString*) sizeKey
{
	ECDataItem* item = self.item;
	
	BOOL change = NO;
	
	CGFloat size;
	NSNumber* sizeValue = [item objectForKey: sizeKey];
	if (sizeValue)
	{
		size = [sizeValue floatValue];
		change = YES;
	}
	else
	{
		size = label.font.pointSize;
	}
	
	NSString* name = [item objectForKey: fontKey];
	if (!name)
	{
		name = label.font.fontName;
		change = YES;
	}
	
	if (change)
	{
		label.font = [UIFont fontWithName: name size: size];
	}
}

// --------------------------------------------------------------------------
//! Setup the item.
// --------------------------------------------------------------------------

- (void) setupForItem: (ECDataItem*) item
{
	self.item = item;
	[self setupStyleOfLabel: self.textLabel fontKey: kLabelFontKey sizeKey: kLabelSizeKey];
	
	NSString* text = [item objectForKey: kValueKey];
	if (!text)
	{
		text = [item objectForKey: kLabelKey];
	}
	self.textLabel.text = text;
	
}

@end
