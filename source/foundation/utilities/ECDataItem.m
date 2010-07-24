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



@implementation ECDataItem

ECPropertySynthesize(data);
ECPropertySynthesize(items);
ECPropertySynthesize(defaults);

// --------------------------------------------------------------------------
//! Return a new empty item, autoreleased.
// --------------------------------------------------------------------------

+ item
{
	return [[[ECDataItem alloc] init] autorelease];
}

// --------------------------------------------------------------------------
//! Default initialisation.
// --------------------------------------------------------------------------

- (id) init
{
	return [self initWithItems: [NSMutableArray array]];
}

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
		self.items = items;
		self.defaults = defaults;
	}
	
	return self;
	
}

// --------------------------------------------------------------------------
//! Initialise with a set of objects and keys.
// --------------------------------------------------------------------------

- (id) initWithObjectsAndKeys: (id) firstObject, ...
{
	NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
	
	va_list args;
    va_start(args, firstObject);
    for (id object = firstObject; object != nil; object = va_arg(args, id))
    {
		NSString* key = va_arg(args, NSString*);
		if (key)
		{
			[data setObject: object forKey: key];
		}
    }
    va_end(args);

	return [self initWithData: [data autorelease] items: [NSMutableArray array] defaults: nil];
}

// --------------------------------------------------------------------------
//! Initialise with a list of sub-items, each of which has a single
//! property set using the same key but different values.
// --------------------------------------------------------------------------

- (id) initWithItemsWithKey: (NSString*) key andValues: (id) firstValue, ... 
{
	NSMutableArray* items = [NSMutableArray array];
	
	va_list args;
    va_start(args, firstValue);
    for (id object = firstValue; object != nil; object = va_arg(args, id))
    {
		ECDataItem* item = [[ECDataItem alloc] initWithObjectsAndKeys: object, key, nil];
		[items addObject: item];
		[item release];
    }
    va_end(args);
	
	return [self initWithItems: items];	
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

@end

