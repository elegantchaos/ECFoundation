// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 31/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECLabelValueEditableCell.h"
#import "ECDataItem.h"

@implementation ECLabelValueEditableCell

enum
{
	kLabelTag,
	kTextTag
};

ECPropertySynthesize(label);
ECPropertySynthesize(text);

// --------------------------------------------------------------------------
//! Initialise the cell.
// --------------------------------------------------------------------------

- (id) initForItem: (ECDataItem*) item reuseIdentifier: (NSString*) identifier
{
	if ((self = [super initForItem: item reuseIdentifier: identifier]) != nil)
	{
		UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(10, 10, 75, 25)];
		label.textAlignment = UITextAlignmentRight;
		label.tag = kLabelTag;
		label.font = [UIFont boldSystemFontOfSize: 14];
		[self.contentView addSubview: label];
		self.label = label;
		[label release];
		
		UITextField* textField = [[UITextField alloc] initWithFrame: CGRectMake(90, 12, 200, 25)];
		textField.clearsOnBeginEditing = NO;
		[textField setDelegate:self];
		textField.returnKeyType = UIReturnKeyDone;
		[textField addTarget:self action:@selector(textFieldDone) forControlEvents:UIControlEventEditingDidEndOnExit];
		self.text = textField;
		[self.contentView addSubview:textField];
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
//	self.label.text = [item objectForKey: kLabelKey];
	self.text.text = [item objectForKey: kValueKey];
	//	[self setupDetail];
	//[self setupAccessory];
}

- (void) textFieldDone: (id) sender
{
	ECDebug(ECLabelValueEditorChannel, @"text field done");
}
@end
