// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 03/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECProperties.h"
#import "ECDataDrivenView.h"

#include <UIKit/UIKit.h>

@class ECDataItem;

@interface ECListTableController : UITableViewController <UITableViewDataSource, UITableViewDelegate, ECDataDrivenView>

// --------------------------------------------------------------------------
// Instance Variables
// --------------------------------------------------------------------------

{
	ECDataItem*						mSelection;		//!< The selected item.
	BOOL							mEditable;		//!< Are the items editable?
	BOOL							mExtensible;	//!< Can we add new items?
	UIBarButtonItem*				mAddButton;		
	BOOL							mIgnoreNextNotification;
	
	ECPropertyVariable(data, ECDataItem*);
}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

ECPropertyRetained(data, ECDataItem*);

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (id) initWithNibName: (NSString*) nibNameOrNil bundle:(NSBundle *)nibBundleOrNil data: (ECDataItem*) data;

@end


