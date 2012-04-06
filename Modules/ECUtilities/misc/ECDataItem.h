// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECCommonKeys.h"

@interface ECDataItem : NSObject 
{
	NSUInteger	mCachedSection;
	NSUInteger	mCachedRow;
	ECDataItem* mCachedSectionData;
	ECDataItem* mCachedRowData;
}

@property (strong, nonatomic) NSMutableDictionary* data;
@property (strong, nonatomic) NSMutableDictionary* defaults;
@property (strong, nonatomic) ECDataItem* parent;
@property (strong, nonatomic) NSMutableArray* items;

+ (ECDataItem*)		item;
+ (ECDataItem*)		itemWithObjectsAndKeys: (id)firstObject, ... NS_REQUIRES_NIL_TERMINATION;
+ (ECDataItem*)		itemWithItems: (NSArray*) items;
+ (ECDataItem*)		itemWithItems: (NSArray*) items parent: (ECDataItem*) parent;
+ (ECDataItem*)		itemWithData: (NSDictionary*) data items: (NSArray*) items parent: (ECDataItem*) parent;
+ (ECDataItem*)		itemWithItemsWithKey: (NSString*) key andValues: (id) firstValue, ... NS_REQUIRES_NIL_TERMINATION;
+ (ECDataItem*)		itemWithNestedDictionary: (NSDictionary*) dictionary;
+ (ECDataItem*)		itemWithContentsOfURL:(NSURL*) url;

- (id)				init;
- (id)				initWithObjectsAndKeys: (id)firstObject, ... NS_REQUIRES_NIL_TERMINATION;
- (id)				initWithItems: (NSArray*) items;
- (id)				initWithItems: (NSArray*) items parent: (ECDataItem*) parent;
- (id)				initWithData: (NSDictionary*) data items: (NSArray*) items parent: (ECDataItem*) parent;
- (id)				initWithItemsWithKey: (NSString*) key andValues: (id) firstValue, ... NS_REQUIRES_NIL_TERMINATION;
- (id)				initWithNestedDictionary: (NSDictionary*) dictionary;
- (id)				initWithContentsOfURL:(NSURL*) url;

- (id)				objectForKey: (id) key;
- (BOOL)			boolForKey: (id) key;
- (NSInteger)		intForKey: (id) key;
- (NSInteger)		intForKey: (id) key orDefault: (NSInteger) defaultValue;
- (void)			setObject: (id) object forKey: (id) key;
- (void)			setDefault: (id) object forKey: (id) key;

- (void)			setBoolean: (BOOL) value forKey: (id) key;
- (void)			setBooleanDefault: (BOOL) value forKey: (id) key;

- (NSUInteger)		count;

- (void)			addItem: (ECDataItem*) item;
- (void)			insertItem: (ECDataItem*) item atIndex: (NSUInteger) index;

- (void)			removeItemAtIndex: (NSUInteger) index;
- (void)			removeItemAtIndexPath: (NSIndexPath*) path;

- (void)			moveItemFromIndex: (NSUInteger) from toIndex: (NSUInteger) to;
- (void)			moveItemFromIndexPath: (NSIndexPath*) fromPath toIndexPath: (NSIndexPath*) toPath;

- (ECDataItem*)		itemAtIndex: (NSUInteger) index;
- (ECDataItem*)		itemAtIndex: (NSUInteger) index inSection: (NSUInteger) section;
- (ECDataItem*)		itemAtIndexPath: (NSIndexPath*) path;
- (ECDataItem*)		itemWithValue: (id) value forKey: (NSString*) key;

- (void)			selectItem: (ECDataItem*) item;
- (void)			selectItemAtIndex: (NSUInteger) index;
- (void)			selectItemAtIndex: (NSUInteger) index inSection: (NSUInteger) section;
- (void)			selectItemAtIndexPath: (NSIndexPath*) path;

- (ECDataItem*)		selectedItem;
- (NSUInteger)		selectedItemIndex;
- (NSIndexPath*)	selectedItemIndexPath;

- (BOOL) containsItem: (ECDataItem*) item;

- (void)			updateParentLinks;
- (void)			postChangedNotifications;
- (void)			postSelectedNotification;
- (void)			postMovedNotificationsFromOldContainer: (ECDataItem*) oldContainer toNewContainer: (ECDataItem*) newContainer;

- (NSDictionary*)	asNestedDictionary;
- (BOOL)			writeToURL:(NSURL*) url atomically:(BOOL)atomically; // the atomically flag is ignored if url of a type that cannot be written atomically.

- (NSComparisonResult)	compareByValueAlphabetical: (ECDataItem*) other;

@end

// --------------------------------------------------------------------------
// Notifications
// --------------------------------------------------------------------------

extern NSString *const DataItemChanged;
extern NSString *const DataItemSelected;
extern NSString *const DataItemChildChanged;

