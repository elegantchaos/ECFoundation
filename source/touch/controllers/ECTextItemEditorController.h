// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 26/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <UIKit/UIKit.h>

#import "ECDataDrivenView.h"

@interface ECTextItemEditorController : UIViewController<ECDataDrivenView, UITextFieldDelegate>
{
	ECPropertyDefineVariable(data, ECDataItem*);
	ECPropertyDefineVariable(editor, UITextField*);
	ECPropertyDefineVariable(label, UILabel*);
}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

ECPropertyRetained(data, ECDataItem*);
ECPropertyRetained(editor, IBOutlet UITextField*);
ECPropertyRetained(label, IBOutlet UILabel*);

// --------------------------------------------------------------------------
// Outlets
// --------------------------------------------------------------------------

#ifndef __OBJC__
@property () IBOutlet UITextField* editor;
#endif

@end
