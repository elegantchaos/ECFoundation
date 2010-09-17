// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 28/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECValueCell.h"

@interface ECBooleanEditableCell : ECValueCell
{
	ECPropertyVariable(key, NSString*);
}

ECPropertyRetained(key, NSString*);

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (id) initForItem: (ECDataItem*) item properties: (NSDictionary*) properties reuseIdentifier: (NSString*) identifier;
- (void) setupForItem:(ECDataItem *)item;

@end
