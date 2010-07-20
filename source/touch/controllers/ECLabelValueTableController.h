// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 20/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

@interface ECLabelValueTableController : NSObject <UITableViewDataSource, UITableViewDelegate>
{
	NSArray*		mData;
}

@property (retain, nonatomic) NSArray* data;

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