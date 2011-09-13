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

#import "ECDictionaryBackedObjectCacheTests.h"
#import "TestDictionaryBackedObject.h"
#import "ECDictionaryBackedObjectCache.h"
#import "ECTestCase.h"

@interface ECDictionaryBackedObjectCacheTests()

@property (nonatomic, retain) NSDictionary* test1;
@property (nonatomic, retain) NSDictionary* test2;
@property (nonatomic, retain) NSArray* testArray;
@property (nonatomic, retain) ECDictionaryBackedObjectCache* testCache;

@end

@implementation ECDictionaryBackedObjectCacheTests

@synthesize test1;
@synthesize test2;
@synthesize testArray;
@synthesize testCache;

// --------------------------------------------------------------------------
//! Set up before each test.
// --------------------------------------------------------------------------

- (void) setUp
{
    self.test1 = [NSDictionary dictionaryWithObjectsAndKeys:
                     @"1", @"TestID",
                     @"Sam", @"TestName",
                     @"Some Text", @"TestText",
                     nil];


    self.test2 = [NSDictionary dictionaryWithObjectsAndKeys:
                  @"2", @"TestID",
                  @"Tom", @"TestName",
                  @"Other Text", @"TestText",
                  nil];

    self.testArray = [NSArray arrayWithObjects:self.test1, self.test2, nil];
    
    self.testCache = [[[ECDictionaryBackedObjectCache alloc] initWithClass:[TestDictionaryBackedObject class]] autorelease];
}

// --------------------------------------------------------------------------
//! Tear down after each test.
// --------------------------------------------------------------------------

- (void) tearDown
{
	self.test1 = nil;
	self.test2 = nil;
	self.testArray = nil;
	self.testCache = nil;
}

- (void)checkObject1:(TestDictionaryBackedObject*)object1
{
    ECTestAssertNotNil(object1, @"object valid");
    
    ECTestAssertTrue([object1.name isEqualToString:@"Sam"], @"name wrong");
    ECTestAssertTrue([object1.text isEqualToString:@"Some Text"], @"text wrong");
    ECTestAssertTrue([object1.objectID isEqualToString:@"1"], @"ID wrong");   
}

- (void)checkObject2:(TestDictionaryBackedObject*)object2
{
    ECTestAssertNotNil(object2, @"object valid");
    
    ECTestAssertTrue([object2.name isEqualToString:@"Tom"], @"name wrong");
    ECTestAssertTrue([object2.text isEqualToString:@"Other Text"], @"text wrong");
    ECTestAssertTrue([object2.objectID isEqualToString:@"2"], @"ID wrong");
    
    
}
// --------------------------------------------------------------------------
//! Test objectWithDictionary
// --------------------------------------------------------------------------

- (void) testObjectWithDictionary
{
    TestDictionaryBackedObject* object1 = (TestDictionaryBackedObject*) [self.testCache objectWithDictionary:self.test1];
    [self checkObject1:object1];
    
    TestDictionaryBackedObject* object2 = (TestDictionaryBackedObject*) [self.testCache objectWithDictionary:self.test2];
    [self checkObject2:object2];
}   

// --------------------------------------------------------------------------
//! Test objectsWithArray
// --------------------------------------------------------------------------

- (void) testObjectsWithArray
{
    NSArray* objects = [self.testCache objectsWithArray:self.testArray]; 
    ECTestAssertNotNil(objects, @"objects valid");
    ECTestAssertTrue([objects count] == 2, @"correct number of objects");
    
    TestDictionaryBackedObject* object1 = [objects objectAtIndex:0];
    [self checkObject1:object1];
    
    TestDictionaryBackedObject* object2 = [objects objectAtIndex:1];
    [self checkObject2:object2];
}


@end
