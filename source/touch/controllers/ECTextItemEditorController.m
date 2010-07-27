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


// --------------------------------------------------------------------------
//! Initialise
// --------------------------------------------------------------------------

- (id) initWithNibName: (NSString*) nibNameOrNil bundle:(NSBundle *)nibBundleOrNil data: (ECDataItem*) data;
{
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) != nil)
	{
		self.data = data;
		
		self.title = [data objectForKey: kValueKey];
	}
	
	return self;
}

// --------------------------------------------------------------------------
//! Set up ui.
// --------------------------------------------------------------------------

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	if (self.editor)
	{
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
