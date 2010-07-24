// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 24/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
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
	ECTestAssertNotNil(item, @"should allocate ok");
	ECTestAssertNotNil(item.data, @"should have data dictionary");
	ECTestAssertNotNil(item.items, @"should have items array");
}

// --------------------------------------------------------------------------
//! Perform tests for an item that was made with makeItemWithData.
// --------------------------------------------------------------------------

- (void) dataTests: (ECDataItem*) item
{
	ECTestAssertTrue([item objectForKey: kKey1] == kData1, @"should have data");
	ECTestAssertTrue([item objectForKey: kKey2] == kData2, @"should have data");
	ECTestAssertTrue([item objectForKey: kKey3] == nil, @"shouldn't have data");
}

// --------------------------------------------------------------------------
//! Perform tests for an item containing items made with makeItems.
// --------------------------------------------------------------------------

- (void) itemsTests: (ECDataItem*) item
{
	ECTestAssertTrue(item.items.count == 2, @"items should be empty");	
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
	
	ECTestAssertNil(item.defaults, @"defaults should be empty");
	ECTestAssertTrue(item.data.count == 0, @"data should be empty");
	ECTestAssertTrue(item.items.count == 0, @"items should be empty");
	
	[item release];
}

// --------------------------------------------------------------------------
//! Test the initWithObjectsAndKeys method.
// --------------------------------------------------------------------------

- (void) testInitWithObjectsAndKeys
{
	ECDataItem* item = [self makeItemWithData];
	ECTestAssertTrue(item.count == 2, @"should have two items");
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
//! Test the initWithItems:defaults method.
// --------------------------------------------------------------------------

- (void) testInitWithItemsDefaults
{
	NSArray* items = [self makeItems];
	ECDataItem* defaults = [self makeItemWithData];
	ECDataItem* item = [[ECDataItem alloc] initWithItems: items defaults: defaults];
	ECTestAssertTrue(item.count == 0, @"should have no data");
	[self basicTests: item];
	[self dataTests: item];
	
	[item release];
	
}

// --------------------------------------------------------------------------
//! Test the initWithData:items:defaults method.
// --------------------------------------------------------------------------

- (void) testInitWithDataItemsDefaults
{
	NSDictionary* data = [NSDictionary dictionaryWithObjectsAndKeys: @"different", kKey1, @"other", kKey3, nil] ;
	NSArray* items = [self makeItems];
	ECDataItem* defaults = [self makeItemWithData];
	
	ECDataItem* item = [[ECDataItem alloc] initWithData: data items: items defaults: defaults];
	[self basicTests: item];
	[self itemsTests: item];

	ECTestAssertTrue([item objectForKey: kKey1] == @"different", @"should get answer from the data, overriding the defaults");
	ECTestAssertTrue([item objectForKey: kKey2] == kData2, @"should get answer from the defaults");
	ECTestAssertTrue([item objectForKey: kKey3] == @"other", @"should get answer from the data");

	[item release];
	
}

@end
