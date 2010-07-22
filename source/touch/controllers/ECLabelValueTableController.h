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
	
	ECPropertyDefineMember(data, NSArray*);
}

ECPropertyDefine(data, NSArray*, retain, nonatomic);

@end

// --------------------------------------------------------------------------
// Data Key Constants
// --------------------------------------------------------------------------

extern NSString *const kHeaderKey;
extern NSString *const kFooterKey;
extern NSString *const kRowsKey;
extern NSString *const kLabelKey;
extern NSString *const kDetailKey;
extern NSString *const kAccessoryKey;
extern NSString *const kDefaultsKey;
extern NSString *const kMoveableKey;
extern NSString *const kSubviewKey;