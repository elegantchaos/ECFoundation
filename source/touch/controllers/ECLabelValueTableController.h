// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 20/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#include "ECProperties.h"

@interface ECLabelValueTableController : NSObject <UITableViewDataSource, UITableViewDelegate>
{
	NSInteger		mCachedSection;
	NSInteger		mCachedRow;
	NSDictionary*	mCachedRowData;
	NSDictionary*	mCachedDefaults;
	
	ECPropertyDefineVariable(data, NSArray*);
}

ECPropertyDefine(data, NSArray*, retain, nonatomic);

@end

