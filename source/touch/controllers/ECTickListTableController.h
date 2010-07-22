// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 22/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECProperties.h"
#import "ECDataDrivenView.h"

@interface ECTickListTableController : UITableViewController <UITableViewDataSource, UITableViewDelegate, ECDataDrivenView>
{
	NSArray*						mValues;		//!< Cached values.
	NSUInteger						mSelection;		//!< Index of selected item.
	
	ECPropertyDefineMember(data, NSDictionary*);
}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

ECPropertyDefine(data, NSDictionary*, retain, nonatomic);

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (void) setData: (NSDictionary*) data defaults: (NSDictionary*) defaults;

@end

// --------------------------------------------------------------------------
// Data Key Constants
// --------------------------------------------------------------------------

extern NSString *const kValuesKey;
