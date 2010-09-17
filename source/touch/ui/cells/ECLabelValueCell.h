// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 31/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "ECValueCell.h"

@class ECDataItem;

@interface ECLabelValueCell : ECValueCell
{
}

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (id) initForItem: (ECDataItem*) item properties: (NSDictionary*) properties reuseIdentifier: (NSString*) identifier;
- (void) setupForItem:(ECDataItem *)item;

// --------------------------------------------------------------------------
// Internal Methods
// --------------------------------------------------------------------------

- (void) setupLabel;
- (void) setupDetail;
- (void) setupAccessory;

@end
