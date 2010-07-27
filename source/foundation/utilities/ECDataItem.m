// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 24/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECDataItem.h"

// --------------------------------------------------------------------------
// Data Key Constants
// --------------------------------------------------------------------------

NSString *const kHeaderKey = @"Header";
NSString *const kFooterKey = @"Footer";
NSString *const kLabelKey = @"Label";
NSString *const kValueKey = @"Value";
NSString *const kAccessoryKey = @"Accessory";
NSString *const kMoveableKey = @"Moveable";
NSString *const kViewerKey = @"Viewer";
NSString *const kViewerNibKey = @"ViewerNib";
NSString *const kEditorKey = @"Editor";
NSString *const kEditorNibKey = @"EditorNib";
NSString *const kSelectionKey = @"Selection";
NSString *const kEditableKey = @"Editable";

NSString *const DataItemChanged = @"ECDataItemChanged";
NSString *const DataItemChildChanged = @"ECDataItemChildChanged";

@interface ECDataItem()
- (void)					addItemsWithKey: (NSString*) key firstValue: (id) firstValue args: (va_list) args;
+ (NSMutableDictionary*)	dataWithObjectsAndKeys: (id) firstObject args: (va_list) args;
@end

@implementation ECDataItem

ECPropertySynthesize(data);
ECPropertySynthesize(defaults);
ECPropertySynthesize(items);
ECPropertySynthesize(parent);

// --------------------------------------------------------------------------
//! Return a new empty item, autoreleased.
// --------------------------------------------------------------------------

+ (ECDataItem*) item
{
	return [[[ECDataItem alloc] init] autorelease];
}

// --------------------------------------------------------------------------
//! Return an auto released item with some data.
// --------------------------------------------------------------------------

+ (ECDataItem*)	itemWithObjectsAndKeys: (id)firstObject, ...
{
	va_list args;
    va_start(args, firstObject);
	NSMutableDictionary* data = [ECDataItem dataWithObjectsAndKeys: firstObject args: args];
    va_end(args);
	
	return [ECDataItem itemWithData: data items: [NSMutableArray array] parent: nil];
}

// --------------------------------------------------------------------------
//! Return an auto released item with some sub-items.
// --------------------------------------------------------------------------

+ (ECDataItem*)	itemWithItems: (NSArray*) items
{
	return [[[ECDataItem alloc] initWithItems: items] autorelease];
}

// --------------------------------------------------------------------------
//! Return an auto released item with some sub items and parent.
// --------------------------------------------------------------------------

+ (ECDataItem*)	itemWithItems: (NSArray*) items parent: (ECDataItem*) parent
{
	return [[[ECDataItem alloc] initWithItems: items parent:parent] autorelease];
	
}

// --------------------------------------------------------------------------
//! Return an auto released item with some data, sub items and parent.
// --------------------------------------------------------------------------

+ (ECDataItem*)	itemWithData: (NSDictionary*) data items: (NSArray*) items parent: (ECDataItem*) parent
{
	return [[[ECDataItem alloc] initWithData: data items: items parent: parent] autorelease];	
}

// --------------------------------------------------------------------------
//! Return an auto released item with a list of sub-items, each of which has a single
//! property set using the same key but different values.
// --------------------------------------------------------------------------

+ (ECDataItem*)	itemWithItemsWithKey: (NSString*) key andValues: (id) firstValue, ...
{
	ECDataItem* item = [ECDataItem item];
	va_list args;
    va_start(args, firstValue);
	[item addItemsWithKey: key firstValue: firstValue args: args];
    va_end(args);
	
	return item;	
}

// --------------------------------------------------------------------------
//! Default initialisation.
// --------------------------------------------------------------------------

- (id) init
{
	return [self initWithItems: [NSMutableArray array]];
}

// --------------------------------------------------------------------------
//! Clean up.
// --------------------------------------------------------------------------

- (void) dealloc
{
	ECPropertyDealloc(data);
	ECPropertyDealloc(defaults);
	ECPropertyDealloc(items);
	ECPropertyDealloc(parent);
	
	[super dealloc];
}

// --------------------------------------------------------------------------
//! Initialise with some existing items.
// --------------------------------------------------------------------------

- (id) initWithItems: (NSArray*) items
{
	return [self initWithItems: items parent: nil];
}

// --------------------------------------------------------------------------
//! Initialise with items and parent.
// --------------------------------------------------------------------------

- (id) initWithItems: (NSArray*) items parent: (ECDataItem*) parent
{
	return [self initWithData: [NSMutableDictionary dictionary] items: items parent: parent];
}

// --------------------------------------------------------------------------
//! Initialise with data, items and parent.
// --------------------------------------------------------------------------

- (id) initWithData: (NSMutableDictionary*) data items: (NSArray*) items parent: (ECDataItem*) parent
{
	if ((self = [super init]) != nil)
	{
		self.data = data;
		self.items = [items mutableCopy];
		self.parent = parent;
	}
	
	return self;
	
}

// --------------------------------------------------------------------------
//! Initialise with a set of objects and keys.
// --------------------------------------------------------------------------

- (id) initWithObjectsAndKeys: (id) firstObject, ...
{
	va_list args;
    va_start(args, firstObject);
	NSMutableDictionary* data = [ECDataItem dataWithObjectsAndKeys: firstObject args: args];
    va_end(args);

	return [self initWithData: data items: [NSMutableArray array] parent: nil];
}

// --------------------------------------------------------------------------
//! Initialise with a set of objects and keys.
// --------------------------------------------------------------------------

+ (NSMutableDictionary*) dataWithObjectsAndKeys: (id) firstObject args: (va_list) args
{
	NSMutableDictionary* data = [NSMutableDictionary dictionary];
	
    for (id object = firstObject; object != nil; object = va_arg(args, id))
    {
		NSString* key = va_arg(args, NSString*);
		if (key)
		{
			[data setObject: object forKey: key];
		}
    }
	
	return data;
}

// --------------------------------------------------------------------------
//! Initialise with a list of sub-items, each of which has a single
//! property set using the same key but different values.
// --------------------------------------------------------------------------

- (id) initWithItemsWithKey: (NSString*) key andValues: (id) firstValue, ... 
{
	ECDataItem* item = [self init];
	
	va_list args;
    va_start(args, firstValue);
	[item addItemsWithKey: key firstValue: firstValue args: args];
    va_end(args);
	
	return item;
}

// --------------------------------------------------------------------------
//! Return a list of sub-items, each of which has a single
//! property set using the same key but different values.
// --------------------------------------------------------------------------

- (void) addItemsWithKey: (NSString*) key firstValue: (id) firstValue args: (va_list) args
{
    for (id object = firstValue; object != nil; object = va_arg(args, id))
    {
		ECDataItem* item = [ECDataItem itemWithObjectsAndKeys: object, key, nil];
		[self addItem: item];
    }
}

// --------------------------------------------------------------------------
//! Return the object for a key. 
//! We look in the data first, then in the parent's defaults (which apply to
//! all of its children). If those both fail, we ask the parent iself.
// --------------------------------------------------------------------------

- (id) objectForKey: (id) key
{
	id result = [self.data objectForKey: key];
	if (!result && self.parent)
	{
		result = [self.parent.defaults objectForKey: key];
		if (!result)
		{
			result = [self.parent objectForKey: key];
		}
	}
	
	return result;
}

// --------------------------------------------------------------------------
//! Return the number of dictionary items we contain directly.
// --------------------------------------------------------------------------

- (NSUInteger) count
{
	return self.data.count;
}

// --------------------------------------------------------------------------
//! Add an item to our item list.
// --------------------------------------------------------------------------

- (void) addItem: (ECDataItem*) item
{
	[self.items addObject: item];
	if (item.parent == nil)
	{
		item.parent = self;
	}
}

// --------------------------------------------------------------------------
//! Insert an item to our item list.
// --------------------------------------------------------------------------

- (void) insertItem:(ECDataItem *)item atIndex:(NSUInteger)index
{
	[self.items insertObject: item atIndex: index];
}

// --------------------------------------------------------------------------
//! Return a given item.
// --------------------------------------------------------------------------

- (ECDataItem*) itemAtIndex:(NSUInteger)index
{
	return [self.items objectAtIndex: index];
}

// --------------------------------------------------------------------------
//! Return an item at a given path.
//!
//! The section of the path is used to index our items, and the row then
//! used to index that item's items.
// --------------------------------------------------------------------------

- (ECDataItem*) itemAtIndexPath: (NSIndexPath*) path
{
	NSUInteger section = path.section;
	if ((mCachedSectionData == nil) || (section != mCachedSection))
	{
		mCachedSection = section;
		mCachedSectionData = [self.items objectAtIndex: path.section];
		mCachedRowData = nil;
	}
	
	NSUInteger row = path.row;
	if ((mCachedRowData == nil) || (row != mCachedRow))
	{
		mCachedRowData = [mCachedSectionData itemAtIndex: row];
		mCachedRow = row;
	}

	return mCachedRowData;
}

- (void) invalidateCaches
{
	mCachedRowData = mCachedSectionData = nil;
}

// --------------------------------------------------------------------------
//! Return a property for a given path.
// --------------------------------------------------------------------------

- (id) objectForKey: (NSString*) key atPath: (NSIndexPath*) path
{
	ECDataItem* item = [self itemAtIndexPath: path];
	id result = [item objectForKey: key];
	
	return result;
}

// --------------------------------------------------------------------------

- (void) setObject: (id) object forKey: (id) key
{
	[self.data setObject: object forKey: key];
}

// --------------------------------------------------------------------------

- (void) removeItemAtIndex: (NSUInteger) index
{
	[self.items removeObjectAtIndex: index];
	[self invalidateCaches];
}

// --------------------------------------------------------------------------

- (void) removeItemAtIndexPath:(NSIndexPath *)path
{
	ECDataItem* sectionItem = [self.items objectAtIndex: path.section];
	[sectionItem removeItemAtIndex: path.row];
	[self invalidateCaches];
}

// --------------------------------------------------------------------------

- (void) moveItemFromIndex: (NSUInteger) from toIndex: (NSUInteger) to
{
	ECDataItem* item = [[self.items objectAtIndex: from] retain];
	[self.items removeObjectAtIndex: from];
	[self.items insertObject: item atIndex: to];
	[self invalidateCaches];
	[item release];
}

// --------------------------------------------------------------------------

- (void) moveItemFromIndexPath: (NSIndexPath*) fromPath toIndexPath: (NSIndexPath*) toPath
{
	ECDataItem* item = [[self itemAtIndexPath: fromPath] retain];
	[self removeItemAtIndexPath: fromPath];
	ECDataItem* toSection = [self.items objectAtIndex: toPath.section];
	[toSection insertItem: item atIndex: toPath.row];
	[item release];
}

// --------------------------------------------------------------------------

- (void) postChangedNotifications
{
	[[NSNotificationCenter defaultCenter] postNotificationName: DataItemChanged object:self];
	if (self.parent)
	{
		[[NSNotificationCenter defaultCenter] postNotificationName: DataItemChildChanged object:self.parent];
	}
}

@end

