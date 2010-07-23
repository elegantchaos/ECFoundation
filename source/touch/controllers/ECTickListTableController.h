// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 22/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECProperties.h"
#import "ECDataDrivenView.h"

@interface ECTickListTableController : UITableViewController <UITableViewDataSource, UITableViewDelegate, ECDataDrivenView>

// --------------------------------------------------------------------------
// Instance Variables
// --------------------------------------------------------------------------

{
	NSMutableArray*					mValues;		//!< Cached values.
	NSUInteger						mSelection;		//!< Index of selected item.
	
	ECPropertyDefineVariable(data, NSDictionary*);
}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

ECPropertyDefine(data, NSDictionary*, retain, nonatomic);

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (id) initWithNibName: (NSString*) nibNameOrNil bundle:(NSBundle *)nibBundleOrNil data: (NSDictionary*) data defaults: (NSDictionary*) defaults;
- (void) setData: (NSDictionary*) data defaults: (NSDictionary*) defaults;

@end

// --------------------------------------------------------------------------
// Data Key Constants
// --------------------------------------------------------------------------

extern NSString *const kValuesKey;
