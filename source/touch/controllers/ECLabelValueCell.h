// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 31/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "ECDataDrivenTableCell.h"

@class ECDataItem;

@interface ECLabelValueCell : UITableViewCell<ECDataDrivenTableCell> 
{
	ECPropertyDefineVariable(item, ECDataItem*);
}

// --------------------------------------------------------------------------
// Public Properties.
// --------------------------------------------------------------------------

ECPropertyDefineRN(item, ECDataItem*);

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (id) initForItem: (ECDataItem*) item reuseIdentifier: (NSString*) identifier;
- (void) setupForItem:(ECDataItem *)item;

// --------------------------------------------------------------------------
// Internal Methods
// --------------------------------------------------------------------------

- (void) setupLabel;
- (void) setupDetail;
- (void) setupAccessory;

// --------------------------------------------------------------------------
//! Style properties.
// --------------------------------------------------------------------------

extern NSString *const kAutocapitalizationTypeKey;
extern NSString *const kAutocorrectionTypeKey;
extern NSString *const kKeyboardTypeKey;
extern NSString *const kKeyboardAppearanceKey;
extern NSString *const kReturnKeyTypeKey;
extern NSString *const kEnablesReturnKeyAutomaticallyKey;

@end
