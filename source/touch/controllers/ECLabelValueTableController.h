// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 20/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#include "ECProperties.h"
#include "ECDataItem.h"

@interface ECLabelValueTableController : NSObject <UITableViewDataSource, UITableViewDelegate>
{
	ECPropertyDefineVariable(data, ECDataItem*);
}

ECPropertyDefineRN(data, ECDataItem*);

@end

