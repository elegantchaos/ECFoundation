// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 31/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECLabelValueEditableCell.h"
#import "ECDataItem.h"
#import "UIColor+ECUtilities.h"

@implementation ECLabelValueEditableCell

static const CGFloat kVerticalInset = 11.0f;
static const CGFloat kHorizontalInset = 32.0f;
static const CGFloat kHorizontalOffset = 32.0f;

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
	if ((self = [super initWithStyle: UITableViewCellStyleValue1 reuseIdentifier: identifier]) != nil)
	{
		CGRect rect = CGRectInset(self.bounds, kHorizontalInset, kVerticalInset);
		rect.origin.x += kHorizontalOffset;
		rect.size.width -= kHorizontalOffset;

		UITextField* textField = [[UITextField alloc] initWithFrame: rect];
		textField.clearsOnBeginEditing = NO;
		textField.textAlignment = UITextAlignmentRight;
		textField.textColor = [UIColor blueTextColor];
        textField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[textField setDelegate:self];
		[textField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
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
	
	self.text.text = [item objectForKey: kValueKey];
	self.text.secureTextEntry = [item boolForKey: kSecureKey];
	self.text.autocapitalizationType = [item intForKey: kAutocapitalizationTypeKey orDefault: UITextAutocapitalizationTypeNone];
	self.text.autocorrectionType = [item intForKey: kAutocorrectionTypeKey orDefault: UITextAutocorrectionTypeNo];
	self.text.keyboardType = [item intForKey: kKeyboardTypeKey orDefault: UIKeyboardTypeDefault];
	self.text.keyboardAppearance = [item intForKey: kKeyboardAppearanceKey orDefault: UIKeyboardAppearanceDefault];
	self.text.returnKeyType = [item intForKey: kReturnKeyTypeKey orDefault: UIReturnKeyDone];
	self.text.enablesReturnKeyAutomatically = [item intForKey: kEnablesReturnKeyAutomaticallyKey orDefault: NO];
}

// --------------------------------------------------------------------------
//! Output debug info on the subviews.
// --------------------------------------------------------------------------

- (void) debugSubviews
{
	for (UIView* view in self.contentView.subviews)
	{
		ECDebug(ECLabelValueEditorChannel, @"view %@", view);
	}
}

// --------------------------------------------------------------------------
//! Handle the end of editing to save the new value of the item.
// --------------------------------------------------------------------------

- (void) textFieldDidEndEditing:(UITextField *)textField
{
	ECDebug(ECLabelValueEditorChannel, @"text end editing");
	[self.item setObject: textField.text forKey:kValueKey];
	[self.item postChangedNotifications];
}

- (void) textFieldDone: (id) sender
{
	ECDebug(ECLabelValueEditorChannel, @"text field done");
	[sender resignFirstResponder];
}

@end
