// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 24/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@interface ECDataItem : NSObject 
{
	ECPropertyDefineVariable(data, NSMutableDictionary*);
	ECPropertyDefineVariable(defaults, ECDataItem*);
	ECPropertyDefineVariable(items, NSMutableArray*);
	
	NSUInteger	mCachedSection;
	NSUInteger	mCachedRow;
	ECDataItem* mCachedSectionData;
	ECDataItem* mCachedRowData;
}

ECPropertyDefineRN(data, NSMutableDictionary*);
ECPropertyDefineRN(defaults, ECDataItem*);
ECPropertyDefineRN(items, NSMutableArray*);

+ (ECDataItem*) item;
+ (ECDataItem*)	itemWithObjectsAndKeys: (id)firstObject, ... NS_REQUIRES_NIL_TERMINATION;
+ (ECDataItem*)	itemWithItems: (NSArray*) items;
+ (ECDataItem*)	itemWithItems: (NSArray*) items defaults: (ECDataItem*) defaults;
+ (ECDataItem*)	itemWithData: (NSDictionary*) data items: (NSArray*) items defaults: (ECDataItem*) defaults;
+ (ECDataItem*)	itemWithItemsWithKey: (NSString*) key andValues: (id) firstValue, ... NS_REQUIRES_NIL_TERMINATION;

- (id)			init;
- (id)			initWithObjectsAndKeys: (id)firstObject, ... NS_REQUIRES_NIL_TERMINATION;
- (id)			initWithItems: (NSArray*) items;
- (id)			initWithItems: (NSArray*) items defaults: (ECDataItem*) defaults;
- (id)			initWithData: (NSDictionary*) data items: (NSArray*) items defaults: (ECDataItem*) defaults;
- (id)			initWithItemsWithKey: (NSString*) key andValues: (id) firstValue, ... NS_REQUIRES_NIL_TERMINATION;

- (id)			objectForKey: (id) key;
- (void)		setObject: (id) object forKey: (id) key;

- (NSUInteger)	count;

- (void)		addItem: (ECDataItem*) item;

- (ECDataItem*)	itemAtIndex: (NSUInteger) index;
- (ECDataItem*) itemAtIndexPath: (NSIndexPath*) path;

@end

// --------------------------------------------------------------------------
// Data Key Constants
// --------------------------------------------------------------------------

extern NSString *const kHeaderKey;
extern NSString *const kFooterKey;
extern NSString *const kItemsKey;
extern NSString *const kLabelKey;
extern NSString *const kDetailKey;
extern NSString *const kAccessoryKey;
extern NSString *const kDefaultsKey;
extern NSString *const kMoveableKey;
extern NSString *const kSubviewKey;
extern NSString *const kValuesKey;
extern NSString *const kEditableKey;
extern NSString *const kSelectionKey;
