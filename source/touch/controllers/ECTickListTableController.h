// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 22/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECProperties.h"
#import "ECDataDrivenView.h"

@class ECDataItem;

@interface ECTickListTableController : UITableViewController <UITableViewDataSource, UITableViewDelegate, ECDataDrivenView>

// --------------------------------------------------------------------------
// Instance Variables
// --------------------------------------------------------------------------

{
	ECDataItem*						mSelection;		//!< The selected item.
	BOOL							mEditable;		//!< Are the items editable?
	
	ECPropertyDefineVariable(data, ECDataItem*);
}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

ECPropertyDefineRN(data, ECDataItem*);

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (id) initWithNibName: (NSString*) nibNameOrNil bundle:(NSBundle *)nibBundleOrNil data: (ECDataItem*) data;

@end


