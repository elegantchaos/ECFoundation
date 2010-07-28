// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 26/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECTextItemEditorController.h"
#import "ECDataItem.h"

@implementation ECTextItemEditorController

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

ECPropertySynthesize(data);
ECPropertySynthesize(editor);
ECPropertySynthesize(label);

// --------------------------------------------------------------------------
//! Initialise
// --------------------------------------------------------------------------

- (id) initWithNibName: (NSString*) nibNameOrNil bundle:(NSBundle *)nibBundleOrNil data: (ECDataItem*) data;
{
	if (!nibNameOrNil)
	{
		nibNameOrNil = @"ECTouchTextItemEditor";
	}
	
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) != nil)
	{
		self.data = data;
		
	}
	
	return self;
}

// --------------------------------------------------------------------------
//! Set up ui.
// --------------------------------------------------------------------------

- (void) viewDidLoad
{
	[super viewDidLoad];

	NSString* title = [self.data objectForKey: kLabelKey];
	if (!title)
	{
		title = [self.data objectForKey: kValueKey];
	}
	
	self.title = title;
	if (self.label)
	{
		self.label.text = title;
	}
	
	if (self.editor)
	{
		self.editor.secureTextEntry = [self.data boolForKey: kSecureKey];
		self.editor.text = [self.data objectForKey: kValueKey];
	}
}

// --------------------------------------------------------------------------
//! Clean up after unloading.
// --------------------------------------------------------------------------

- (void) viewDidUnload 
{
    [super viewDidUnload];

	self.editor = nil;
}

// --------------------------------------------------------------------------
//! Release references and clean up.
// --------------------------------------------------------------------------

- (void) dealloc 
{
	ECPropertyDealloc(data);
	ECPropertyDealloc(editor);
	ECPropertyDealloc(label);

    [super dealloc];
}

// --------------------------------------------------------------------------
//! Try to deal with low memory.
// --------------------------------------------------------------------------

- (void) didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

// --------------------------------------------------------------------------
//! Update the text value.
// --------------------------------------------------------------------------

- (void) textFieldDidEndEditing: (UITextField*) field
{
	[self.data setObject: field.text forKey: kValueKey];
	[self.data postChangedNotifications];
}

@end
