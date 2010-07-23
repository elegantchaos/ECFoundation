//
//  ECDataItem.m
//  ECFoundation
//
//  Created by Sam Deane on 23/07/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//

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


- (id) init
{
	return [self initWithItems: [NSMutableArray array]];
}

- (id) initWithItems: (NSArray*) items
{
	return [self initWithItems: items defaults: [NSMutableDictionary dictionary]];
}

- (id) initWithItems: (NSArray*) items defaults: (NSDictionary*) defaults
{
	return [self initWithData: [NSMutableDictionary dictionary] items: items defaults: defaults];
}

- (id) initWithData: (NSDictionary*) data items: (NSArray*) items defaults: (NSDictionary*) defaults
{
	if ((self = [super init]) != nil)
	{
		self.data = data;
		self.items = items;
		self.defaults= defaults;
	}
	
	return self;
	
}

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

	return [self initWithData: [data autorelease] items: [NSMutableArray array] defaults: [NSMutableDictionary dictionary]];
}

@end

