// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 20/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECProperties.h"
#import "ECDataItem.h"

#import <UIKit/UIKit.h>

@interface ECLabelValueTableController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
	ECPropertyDefineVariable(data, ECDataItem*);
	ECPropertyDefineVariable(cellClass, Class);
}

ECPropertyDefineRN(data, ECDataItem*);
ECPropertyDefineAN(cellClass, Class);

@end

