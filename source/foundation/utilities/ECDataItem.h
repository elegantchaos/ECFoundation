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
	ECPropertyDefineVariable(defaults, NSMutableDictionary*);
	ECPropertyDefineVariable(parent, ECDataItem*);
	ECPropertyDefineVariable(items, NSMutableArray*);
	
	NSUInteger	mCachedSection;
	NSUInteger	mCachedRow;
	ECDataItem* mCachedSectionData;
	ECDataItem* mCachedRowData;
}

ECPropertyDefineRN(data, NSMutableDictionary*);
ECPropertyDefineRN(defaults, NSMutableDictionary*);
ECPropertyDefineRN(parent, ECDataItem*);
ECPropertyDefineRN(items, NSMutableArray*);

+ (ECDataItem*) item;
+ (ECDataItem*)	itemWithObjectsAndKeys: (id)firstObject, ... NS_REQUIRES_NIL_TERMINATION;
+ (ECDataItem*)	itemWithItems: (NSArray*) items;
+ (ECDataItem*)	itemWithItems: (NSArray*) items parent: (ECDataItem*) parent;
+ (ECDataItem*)	itemWithData: (NSDictionary*) data items: (NSArray*) items parent: (ECDataItem*) parent;
+ (ECDataItem*)	itemWithItemsWithKey: (NSString*) key andValues: (id) firstValue, ... NS_REQUIRES_NIL_TERMINATION;

- (id)			init;
- (id)			initWithObjectsAndKeys: (id)firstObject, ... NS_REQUIRES_NIL_TERMINATION;
- (id)			initWithItems: (NSArray*) items;
- (id)			initWithItems: (NSArray*) items parent: (ECDataItem*) parent;
- (id)			initWithData: (NSDictionary*) data items: (NSArray*) items parent: (ECDataItem*) parent;
- (id)			initWithItemsWithKey: (NSString*) key andValues: (id) firstValue, ... NS_REQUIRES_NIL_TERMINATION;

- (id)			objectForKey: (id) key;
- (void)		setObject: (id) object forKey: (id) key;

- (NSUInteger)	count;

- (void)		addItem: (ECDataItem*) item;
- (void)		insertItem: (ECDataItem*) item atIndex: (NSUInteger) index;

- (void)		removeItemAtIndex: (NSUInteger) index;
- (void)		removeItemAtIndexPath: (NSIndexPath*) path;

- (void)		moveItemFromIndex: (NSUInteger) from toIndex: (NSUInteger) to;
- (void)		moveItemFromIndexPath: (NSIndexPath*) fromPath toIndexPath: (NSIndexPath*) toPath;

- (ECDataItem*)	itemAtIndex: (NSUInteger) index;
- (ECDataItem*) itemAtIndexPath: (NSIndexPath*) path;

- (void)		selectItemAtIndex: (NSUInteger) index;
- (void)		selectItemAtIndex: (NSUInteger) index inSection: (NSUInteger) section;
- (void)		selectItemAtIndexPath: (NSIndexPath*) path;

- (void)		postChangedNotifications;

@end

// --------------------------------------------------------------------------
// Data Key Constants
// --------------------------------------------------------------------------

extern NSString *const kHeaderKey;
extern NSString *const kFooterKey;
extern NSString *const kLabelKey;
extern NSString *const kValueKey;
extern NSString *const kAccessoryKey;
extern NSString *const kMoveableKey;
extern NSString *const kViewerKey;
extern NSString *const kViewerNibKey;
extern NSString *const kEditorKey;
extern NSString *const kEditorNibKey;
extern NSString *const kEditableKey;
extern NSString *const kSelectionKey;

// --------------------------------------------------------------------------
// Notifications
// --------------------------------------------------------------------------

extern NSString *const DataItemChanged;
extern NSString *const DataItemChildChanged;

