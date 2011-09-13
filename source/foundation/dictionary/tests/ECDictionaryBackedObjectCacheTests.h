// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//! @file:
//! Unit tests for the NSDate+ECUtilitiesTests.h category.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTestCase.h"

@class ECDictionaryBackedObjectCache;

@interface ECDictionaryBackedObjectCacheTests : ECTestCase
{
@private
	NSDictionary* _test1;
	NSDictionary* _test2;
	NSArray* _testArray;
	ECDictionaryBackedObjectCache* _testCache;
}

@end
