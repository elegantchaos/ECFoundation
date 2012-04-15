// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//! @file:
//! Unit tests for the NSDate+ECUtilitiesTests.h category.
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTestCase.h"
#import "TestDictionaryBackedObject.h"

@interface ECDictionaryBackedObjectTests : ECTestCase
{
@private
	NSDictionary* testData;
}

@end

@interface ECDictionaryBackedObjectTests()

@property (nonatomic, retain) NSDictionary* testData;

@end

@implementation ECDictionaryBackedObjectTests

@synthesize testData;

// --------------------------------------------------------------------------
//! Set up before each test.
// --------------------------------------------------------------------------

- (void) setUp
{
    self.testData = [NSDictionary dictionaryWithObjectsAndKeys:
                     @"1", @"TestID",
                     @"Sam", @"TestName",
                     @"Some Text", @"TestText",
                     nil];
}

// --------------------------------------------------------------------------
//! Tear down after each test.
// --------------------------------------------------------------------------

- (void) tearDown
{
    self.testData = nil;
}

// --------------------------------------------------------------------------
//! Test objectWithDictionary
// --------------------------------------------------------------------------

- (void) testObjectWithDictionary
{
    TestDictionaryBackedObject* object = (TestDictionaryBackedObject*) [TestDictionaryBackedObject objectWithDictionary:self.testData]; 
    ECTestAssertNotNil(object);
    
    ECTestAssertTrue([object.name isEqualToString:@"Sam"]);
    ECTestAssertTrue([object.text isEqualToString:@"Some Text"]);
    ECTestAssertTrue([object.objectID isEqualToString:@"1"]);
}

// --------------------------------------------------------------------------
//! Test objectWithDictionary
// --------------------------------------------------------------------------

- (void) testUpdateWithDictionary
{
    TestDictionaryBackedObject* object = (TestDictionaryBackedObject*) [TestDictionaryBackedObject objectWithDictionary:self.testData]; 
    ECTestAssertNotNil(object);
    
    NSDictionary* update = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"Tom", @"TestName",
                            @"Different Text", @"TestText",
                            @"Random Value", @"RandomKey",
                            nil];
    [object updateFromDictionary:update];
    
    ECTestAssertTrue([object.name isEqualToString:@"Tom"]);
    ECTestAssertTrue([object.text isEqualToString:@"Different Text"]);
    ECTestAssertTrue([object.objectID isEqualToString:@"1"]);
}

@end
