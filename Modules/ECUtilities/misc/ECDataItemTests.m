// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------


#import "ECDataItemTests.h"
#import "ECDataItem.h"

@implementation ECDataItemTests

static NSString *const kKey1 = @"key1";
static NSString *const kKey2 = @"key2";
static NSString *const kKey3 = @"key3";

static NSString *const kData1 = @"data1";
static NSString *const kData2 = @"data2";

// --------------------------------------------------------------------------
//! Perform basic tests for any initialised ECDataItem.
// --------------------------------------------------------------------------

- (void) basicTests: (ECDataItem*) item
{
	ECTestAssertNotNil(item);
	ECTestAssertNotNil(item.data);
	ECTestAssertNotNil(item.items);
}

// --------------------------------------------------------------------------
//! Perform tests for an item that was made with makeItemWithData.
// --------------------------------------------------------------------------

- (void) dataTests: (ECDataItem*) item
{
	ECTestAssertTrue([item objectForKey: kKey1] == kData1);
	ECTestAssertTrue([item objectForKey: kKey2] == kData2);
	ECTestAssertTrue([item objectForKey: kKey3] == nil);
}

// --------------------------------------------------------------------------
//! Perform tests for an item containing items made with makeItems.
// --------------------------------------------------------------------------

- (void) itemsTests: (ECDataItem*) item
{
	ECTestAssertTrue(item.items.count == 2);	
}

// --------------------------------------------------------------------------
//! Make a test item with some data.
// --------------------------------------------------------------------------

- (ECDataItem*) makeItemWithData
{
	ECDataItem* item = [[ECDataItem alloc] initWithObjectsAndKeys: kData1, kKey1, kData2, kKey2, nil];
	return [item autorelease];
}

// --------------------------------------------------------------------------
//! Make a test array of two items.
// --------------------------------------------------------------------------

- (NSArray*) makeItems
{
	NSArray* items = [NSArray arrayWithObjects: [self makeItemWithData], [self makeItemWithData], nil];
	return items;
}

// --------------------------------------------------------------------------
//! Test the init method.
// --------------------------------------------------------------------------

- (void) testPlainInit
{
	ECDataItem* item = [[ECDataItem alloc] init];
	[self basicTests: item];
	
	ECTestAssertNil(item.defaults);
	ECTestAssertTrue(item.data.count == 0);
	ECTestAssertTrue(item.items.count == 0);
	
	[item release];
}

// --------------------------------------------------------------------------
//! Test the initWithObjectsAndKeys method.
// --------------------------------------------------------------------------

- (void) testInitWithObjectsAndKeys
{
	ECDataItem* item = [self makeItemWithData];
	ECTestAssertTrue(item.count == 2);
	[self basicTests: item];
	[self dataTests: item];
}

// --------------------------------------------------------------------------
//! Test the initWithItems method.
// --------------------------------------------------------------------------

- (void) testInitWithItems
{
	NSArray* items = [self makeItems];
	ECDataItem* item = [[ECDataItem alloc] initWithItems: items];
	[self basicTests: item];
	[self itemsTests: item];
	
	[item release];
	
}

// --------------------------------------------------------------------------
//! Test the initWithItems:parent method.
// --------------------------------------------------------------------------

- (void) testInitWithItemsParent
{
	NSArray* items = [self makeItems];
	ECDataItem* parent = [self makeItemWithData];
	ECDataItem* item = [[ECDataItem alloc] initWithItems: items parent: parent];
	ECTestAssertTrue(item.count == 0);
	[self basicTests: item];
	[self dataTests: item];
	
	[item release];
	
}

// --------------------------------------------------------------------------
//! Test setting defaults on the parent
// --------------------------------------------------------------------------

- (void) testParentDefaults
{
	NSArray* items = [self makeItems];
	ECDataItem* parent = [ECDataItem item];
	parent.defaults = [NSMutableDictionary dictionaryWithObjectsAndKeys: kData1, kKey1, kData2, kKey2, nil];
	ECDataItem* item = [[ECDataItem alloc] initWithItems: items parent: parent];
	ECTestAssertTrue(item.count == 0);
	[self basicTests: item];
	[self dataTests: item];
	
	[item release];
	
}

// --------------------------------------------------------------------------
//! Test the initWithData:items:defaults method.
// --------------------------------------------------------------------------

- (void) testInitWithDataItemsParent
{
	NSDictionary* data = [NSDictionary dictionaryWithObjectsAndKeys: @"different", kKey1, @"other", kKey3, nil] ;
	NSArray* items = [self makeItems];
	ECDataItem* parent = [self makeItemWithData];
	
	ECDataItem* item = [[ECDataItem alloc] initWithData: data items: items parent: parent];
	[self basicTests: item];
	[self itemsTests: item];

	ECTestAssertTrue([item objectForKey: kKey1] == @"different");
	ECTestAssertTrue([item objectForKey: kKey2] == kData2);
	ECTestAssertTrue([item objectForKey: kKey3] == @"other");

	[item release];
	
}

// --------------------------------------------------------------------------
//! Test the setObject method.
// --------------------------------------------------------------------------

- (void) testSetObject
{
	ECDataItem* item = [ECDataItem item];
	[self basicTests: item];
	
	[item setObject: kData1 forKey: kKey1];
	[item setObject: kData2 forKey: kKey2];
	[self dataTests: item];
}

// --------------------------------------------------------------------------
//! Test add item
// --------------------------------------------------------------------------

- (void) testAddItem
{
	ECDataItem* item = [ECDataItem item];
	[self basicTests: item];
	
	[item addItem: [self makeItemWithData]];
	[item addItem: [self makeItemWithData]];

	[self itemsTests: item];
}


// --------------------------------------------------------------------------
//! Test inserting and removing items
// --------------------------------------------------------------------------

- (void) testInsertRemoveItem
{
	ECDataItem* item = [ECDataItem item];
	[self basicTests: item];
	
	ECDataItem* child1 = [self makeItemWithData];
	
	[item insertItem: child1 atIndex: 0]; // insert into empty item
	ECTestAssertTrue([item itemAtIndex: 0] == child1);
	[item insertItem: [self makeItemWithData] atIndex: 1]; // insert at end
	ECTestAssertTrue([item itemAtIndex: 0] == child1);
	[item insertItem: [self makeItemWithData] atIndex: 0]; // insert at beginning
	ECTestAssertTrue([item itemAtIndex: 1] == child1);
	[item insertItem: [self makeItemWithData] atIndex: 1]; // insert in middle
	ECTestAssertTrue([item itemAtIndex: 2] == child1);
	[item insertItem: [self makeItemWithData] atIndex: 4]; // insert at end
	ECTestAssertTrue([item itemAtIndex: 2] == child1);
	
	[item removeItemAtIndex: 0]; // remove from beginning
	ECTestAssertTrue([item itemAtIndex: 1] == child1);
	[item removeItemAtIndex: 3]; // remove from end
	ECTestAssertTrue([item itemAtIndex: 1] == child1);
	[item moveItemFromIndex: 1 toIndex: 2];
	ECTestAssertTrue([item itemAtIndex: 2] == child1);
	[item removeItemAtIndex: 1]; // remove from middle
	ECTestAssertTrue([item itemAtIndex: 1] == child1);
	
	[self itemsTests: item];
}

// --------------------------------------------------------------------------
//! Test index paths
// --------------------------------------------------------------------------

- (void) testIndexPaths
{
	ECDataItem* parent = [ECDataItem item];
	ECDataItem* item = [ECDataItem item];
	ECDataItem* child = [ECDataItem item];
	
	[parent addItem: item];
	[item addItem: child];
	
	NSUInteger indexes[] = { 0, 0 };
	NSIndexPath* path = [NSIndexPath indexPathWithIndexes: indexes length: 2];
	
	ECTestAssertTrue([parent itemAtIndexPath: path] == child);
	
	[parent removeItemAtIndexPath: path];
	ECTestAssertTrue([item.items count] == 0);
}

@end
