//
//  ECDataItemTests.m
//  ECFoundation
//
//  Created by Sam Deane on 23/07/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//

#import "ECDataItemTests.h"
#import "ECDataItem.h"

@implementation ECDataItemTests

- (void) testPlainInit
{
	ECDataItem* item = [[ECDataItem alloc] init];
	
	ECTestAssertNotNil(item, @"should allocate ok");
	ECTestAssertNotNil(item.data, @"should have data dictionary");
	ECTestAssertNotNil(item.defaults, @"should have defaults dictionary");
	ECTestAssertNotNil(item.items, @"should have items array");
	ECTestAssertTrue(item.data.count == 0, @"data should be empty");
	ECTestAssertTrue(item.defaults.count == 0, @"defaults should be empty");
	ECTestAssertTrue(item.items.count == 0, @"items should be empty");
	
	[item release];
}

- (void) testInitWithObjectsAndKeys
{
	ECDataItem* item = [[ECDataItem alloc] initWithObjectsAndKeys: @"data1", @"key1", @"data2", @"key2", nil];

	ECTestAssertNotNil(item, @"should allocate ok");
	ECTestAssertNotNil(item.data, @"should have data dictionary");
	ECTestAssertNotNil(item.defaults, @"should have defaults dictionary");
	ECTestAssertNotNil(item.items, @"should have items array");

	[item release];
	
}

- (void) testInitWithItems
{
	NSArray* items = nil;
	ECDataItem* item = [[ECDataItem alloc] initWithItems: items];

	ECTestAssertNotNil(item, @"should allocate ok");
	ECTestAssertNotNil(item.data, @"should have data dictionary");
	ECTestAssertNotNil(item.defaults, @"should have defaults dictionary");
	ECTestAssertNotNil(item.items, @"should have items array");

	[item release];
	
}

- (void) testInitWithItemsDefaults
{
	NSArray* items = nil;
	NSDictionary* defaults = nil;
	ECDataItem* item = [[ECDataItem alloc] initWithItems: items defaults: defaults];

	ECTestAssertNotNil(item, @"should allocate ok");
	ECTestAssertNotNil(item.data, @"should have data dictionary");
	ECTestAssertNotNil(item.defaults, @"should have defaults dictionary");
	ECTestAssertNotNil(item.items, @"should have items array");

	[item release];
	
}

- (void) testInitWithDataItemsDefaults
{
	NSDictionary* data = nil;
	NSArray* items = nil;
	NSDictionary* defaults = nil;
	
	ECDataItem* item = [[ECDataItem alloc] initWithData: data items: items defaults: defaults];

	ECTestAssertNotNil(item, @"should allocate ok");
	ECTestAssertNotNil(item.data, @"should have data dictionary");
	ECTestAssertNotNil(item.defaults, @"should have defaults dictionary");
	ECTestAssertNotNil(item.items, @"should have items array");

	[item release];
	
}

@end
