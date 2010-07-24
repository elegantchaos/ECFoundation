// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 20/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#include "ECProperties.h"

@class ECDataItem;

@interface ECLabelValueTableController : NSObject <UITableViewDataSource, UITableViewDelegate>
{
	NSInteger		mCachedSection;
	NSInteger		mCachedRow;
	ECDataItem*		mCachedRowData;
	ECDataItem*		mCachedDefaults;
	
	ECPropertyDefineVariable(data, ECDataItem*);
}

ECPropertyDefineRN(data, ECDataItem*);

@end

