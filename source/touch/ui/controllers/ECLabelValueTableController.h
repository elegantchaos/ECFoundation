// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 20/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECProperties.h"
#import "ECDataItem.h"
#import "ECDataDrivenView.h"

#import <UIKit/UIKit.h>

@interface ECLabelValueTableController : UITableViewController <UITableViewDataSource, UITableViewDelegate, ECDataDrivenView>
{
	ECPropertyVariable(data, ECDataItem*);
	ECPropertyVariable(cellClass, Class);
}

ECPropertyRetained(data, ECDataItem*);
ECPropertyAssigned(cellClass, Class);

- (id) initWithNibName: (NSString*) nibNameOrNil bundle:(NSBundle *)nibBundleOrNil data: (ECDataItem*) data;

@end

