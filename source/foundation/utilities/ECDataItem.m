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
NSString *const kItemsKey = @"Items";
NSString *const kLabelKey = @"Label";
NSString *const kDetailKey = @"Detail";
NSString *const kAccessoryKey = @"Accessory";
NSString *const kDefaultsKey = @"Defaults";
NSString *const kMoveableKey = @"Moveable";
NSString *const kSubviewKey = @"Subview";
NSString *const kValuesKey = @"Values";
NSString *const kSelectionKey = @"Selection";
NSString *const kEditableKey = @"Editable";


@interface ECDataItem()
+ (NSMutableArray*)			itemsWithKey: (NSString*) key firstValue: (id) firstValue args: (va_list) args;
+ (NSMutableDictionary*)	dataWithObjectsAndKeys: (id) firstObject args: (va_list) args;
@end

@implementation ECDataItem

ECPropertySynthesize(data);
ECPropertySynthesize(items);
ECPropertySynthesize(defaults);

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
	
	return [ECDataItem itemWithData: data items: [NSMutableArray array] defaults: nil];
}

// --------------------------------------------------------------------------
//! Return an auto released item with some sub-items.
// --------------------------------------------------------------------------

+ (ECDataItem*)	itemWithItems: (NSArray*) items
{
	return [[[ECDataItem alloc] initWithItems: items] autorelease];
}

// --------------------------------------------------------------------------
//! Return an auto released item with some sub items and defaults.
// --------------------------------------------------------------------------

+ (ECDataItem*)	itemWithItems: (NSArray*) items defaults: (ECDataItem*) defaults
{
	return [[[ECDataItem alloc] initWithItems: items defaults:defaults] autorelease];
	
}

// --------------------------------------------------------------------------
//! Return an auto released item with some data, sub items and defaults.
// --------------------------------------------------------------------------

+ (ECDataItem*)	itemWithData: (NSDictionary*) data items: (NSArray*) items defaults: (ECDataItem*) defaults
{
	return [[[ECDataItem alloc] initWithData: data items: items defaults: defaults] autorelease];	
}

// --------------------------------------------------------------------------
//! Return an auto released item with a list of sub-items, each of which has a single
//! property set using the same key but different values.
// --------------------------------------------------------------------------

+ (ECDataItem*)	itemWithItemsWithKey: (NSString*) key andValues: (id) firstValue, ...
{
	va_list args;
    va_start(args, firstValue);
	NSMutableArray* items = [ECDataItem itemsWithKey: key firstValue: firstValue args: args];
    va_end(args);
	
	return [ECDataItem itemWithItems: items];	
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
	ECPropertyDealloc(items);
	ECPropertyDealloc(defaults);
	
	[super dealloc];
}

// --------------------------------------------------------------------------
//! Initialise with some existing items.
// --------------------------------------------------------------------------

- (id) initWithItems: (NSArray*) items
{
	return [self initWithItems: items defaults: nil];
}

// --------------------------------------------------------------------------
//! Initialise with items and defaults.
// --------------------------------------------------------------------------

- (id) initWithItems: (NSArray*) items defaults: (ECDataItem*) defaults
{
	return [self initWithData: [NSMutableDictionary dictionary] items: items defaults: defaults];
}

// --------------------------------------------------------------------------
//! Initialise with data, items and defaults.
// --------------------------------------------------------------------------

- (id) initWithData: (NSDictionary*) data items: (NSArray*) items defaults: (ECDataItem*) defaults
{
	if ((self = [super init]) != nil)
	{
		self.data = data;
		self.items = [items mutableCopy];
		self.defaults = defaults;
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

	return [self initWithData: data items: [NSMutableArray array] defaults: nil];
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
	va_list args;
    va_start(args, firstValue);
	NSMutableArray* items = [ECDataItem itemsWithKey: key firstValue: firstValue args: args];
    va_end(args);
	
	return [self initWithItems: items];	
}

// --------------------------------------------------------------------------
//! Return a list of sub-items, each of which has a single
//! property set using the same key but different values.
// --------------------------------------------------------------------------

+ (NSMutableArray*) itemsWithKey: (NSString*) key firstValue: (id) firstValue args: (va_list) args
{
	NSMutableArray* items = [NSMutableArray array];
	
    for (id object = firstValue; object != nil; object = va_arg(args, id))
    {
		ECDataItem* item = [ECDataItem itemWithObjectsAndKeys: object, key, nil];
		[items addObject: item];
    }
	
	return items;
}

// --------------------------------------------------------------------------
//! Return the object for a key. We look in the data first, then in the defaults.
// --------------------------------------------------------------------------

- (id) objectForKey: (id) key
{
	id result = [self.data objectForKey: key];
	if (!result && self.defaults)
	{
		result = [self.defaults objectForKey: key];
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
		mCachedRow = -1;
	}
	
	NSUInteger row = path.row;
	if ((mCachedRowData == nil) || (row != mCachedRow))
	{
		mCachedRowData = [mCachedSectionData itemAtIndex: row];
		mCachedRow = row;
	}

	return mCachedRowData;
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

@end

