// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 26/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <UIKit/UIKit.h>

#import "ECDataDrivenView.h"

@interface ECTextItemEditorController : UIViewController<ECDataDrivenView>
{
	ECPropertyDefineVariable(data, ECDataItem*);
	ECPropertyDefineVariable(editor, UITextField*);
}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

ECPropertyDefineRN(data, ECDataItem*);
ECPropertyDefineRN(editor, IBOutlet UITextField*);

// --------------------------------------------------------------------------
// Outlets
// --------------------------------------------------------------------------

#ifndef __OBJC__
@property () IBOutlet UITextField* editor;
#endif

@end
