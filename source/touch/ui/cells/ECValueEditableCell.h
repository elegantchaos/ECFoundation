// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 31/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "ECLabelValueCell.h"

@interface ECValueEditableCell : ECLabelValueCell<UITextFieldDelegate> 
{
	ECPropertyVariable(label, UILabel*);
	ECPropertyVariable(text, UITextField*);
}

ECPropertyRetained(label, UILabel*);
ECPropertyRetained(text, UITextField*);

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (id) initForItem: (ECDataItem*) item properties: (NSDictionary*) properties reuseIdentifier: (NSString*) identifier;
- (void) setupForItem:(ECDataItem *)item;

@end
