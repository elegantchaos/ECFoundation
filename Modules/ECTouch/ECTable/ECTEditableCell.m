// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 02/09/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTEditableCell.h"
#import "ECTBinding.h"
#import "UIColor+ECUtilities.h"

#pragma mark - Private Interface

@interface ECTEditableCell()

- (void)textFieldDone:(id)sender;

@end


@implementation ECTEditableCell

static const CGFloat kVerticalInset = 11.0f;
static const CGFloat kHorizontalInset = 32.0f;

// --------------------------------------------------------------------------
// Constants
// --------------------------------------------------------------------------

enum
{
	kLabelTag,
	kTextTag
};

// --------------------------------------------------------------------------
// Debug Channels.
// --------------------------------------------------------------------------

ECDefineLogChannel(ItemCellChannel);

#pragma mark Properties

@synthesize label;
@synthesize text;

// --------------------------------------------------------------------------
//! Initialise with a data item.
// --------------------------------------------------------------------------

- (id)initWithBinding:(ECTBinding *)binding section:(ECTSection *)section reuseIdentifier:(NSString *)reuseIdentifier
{
    //    if ((self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) != nil)
    if ((self = [super initWithBinding:binding section:section reuseIdentifier:reuseIdentifier]) != nil)
	{
		CGRect rect;
		rect.origin.x = kHorizontalInset;
		rect.origin.y = kVerticalInset;
		rect.size.width = self.bounds.size.width - (kHorizontalInset * 2);
		rect.size.height = self.bounds.size.height - (kVerticalInset * 2);
		
        self.detailTextLabel.hidden = YES;

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


- (void)updateUIForEvent:(UpdateEvent)event
{
    ECTBinding* binding = self.representedObject;
    NSString* value = [binding valueForSection:self.section];
  	self.text.text = value;  
    
    [super updateUIForEvent:event];
}

// --------------------------------------------------------------------------
//! Setup the item.
// --------------------------------------------------------------------------

- (void)setupForBinding:(ECTBinding*)binding section:(ECTSection*)section
{
    

    //	[self setupStyleOfLabel: self.textLabel key: kLabelStyleKey];
    //	self.textLabel.text = [self itemObjectForKey: kLabelKey];

	CGRect rect;
	rect.origin.x = kHorizontalInset;
	rect.origin.y = kVerticalInset;
	rect.size.width = self.bounds.size.width - (kHorizontalInset * 2);
	rect.size.height = self.bounds.size.height - (kVerticalInset * 2);
	self.text.bounds = rect;
	
    //	NSDictionary* info = [self itemObjectForKey: kValueStyleKey];
    //	UIFont* font = [info objectForKey: kFontKey];
    //	if (font)
    //	{
    //		self.text.font = font;
    //	}
	
    [super setupForBinding:binding section:section];
    //	self.text.secureTextEntry = [self itemBoolForKey: kSecureKey];
    //	self.text.autocapitalizationType = [self itemIntForKey: kAutocapitalizationTypeKey orDefault: UITextAutocapitalizationTypeNone];
    //	self.text.autocorrectionType = [self itemIntForKey: kAutocorrectionTypeKey orDefault: UITextAutocorrectionTypeNo];
    //	self.text.keyboardType = [self itemIntForKey: kKeyboardTypeKey orDefault: UIKeyboardTypeDefault];
    //	self.text.keyboardAppearance = [self itemIntForKey: kKeyboardAppearanceKey orDefault: UIKeyboardAppearanceDefault];
    //	self.text.returnKeyType = [self itemIntForKey: kReturnKeyTypeKey orDefault: UIReturnKeyDone];
    //	self.text.enablesReturnKeyAutomatically = [self itemIntForKey: kEnablesReturnKeyAutomaticallyKey orDefault: NO];
}

// --------------------------------------------------------------------------
//! Handle the end of editing to save the new value of the item.
// --------------------------------------------------------------------------

- (void) textFieldDidEndEditing:(UITextField *)textField
{
	ECDebug(ItemCellChannel, @"text end editing");
    
    [self.representedObject didSetValue:textField.text forCell:self];
}

// --------------------------------------------------------------------------
//! Handle stopping editing for any reason.
// --------------------------------------------------------------------------

- (void) textFieldDone: (id) sender
{
	ECDebug(ItemCellChannel, @"text field done");
	[sender resignFirstResponder];
}

@end
