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
#import "ECLazyProperties.h"

#pragma mark Test Class with Lazy Property


static NSUInteger gTest2initCalled = 0;

@interface TestClass : NSObject

@property (nonatomic, retain) NSString* test;
@property (nonatomic, retain) NSString* test2;

- (NSString*)initTest2;

@end

@implementation TestClass

@lazy_synthesize(test, @"test value"); 
@lazy_synthesize_method(test2, initTest2); 

+ (void)initialize
{
	if (self == [TestClass class])
	{
		[self initializeLazyProperties];
	}
}

- (NSString*)initTest2
{
	gTest2initCalled++;
	return @"test2 value";
}

@end

@interface ECLazyPropertiesTest : ECTestCase

@end

@implementation ECLazyPropertiesTest


- (void) testInitWithSimpleValue
{
    TestClass* test1 = [[TestClass alloc] init];
    TestClass* test2 = [[TestClass alloc] init];
    
    ECTestAssertStringIsEqual(test1.test, @"test value");
    test1.test = @"something else";
    ECTestAssertStringIsEqual(test1.test, @"something else");
    
    ECTestAssertStringIsEqual(test2.test, @"test value");
    test2.test = @"doodah";
    ECTestAssertStringIsEqual(test2.test, @"doodah");
	
    [test1 release];
    [test2 release];
}

- (void) testInitWithMethod
{
	gTest2initCalled = 0;
	
    TestClass* test1 = [[TestClass alloc] init];
    TestClass* test2 = [[TestClass alloc] init];
    
    ECTestAssertStringIsEqual(test1.test2, @"test2 value");
    test1.test2 = @"something else";
    ECTestAssertStringIsEqual(test1.test2, @"something else");
    
    ECTestAssertStringIsEqual(test2.test2, @"test2 value");
    test2.test2 = @"doodah";
    ECTestAssertStringIsEqual(test2.test2, @"doodah");
	
    [test1 release];
    [test2 release];
	
	ECTestAssertIntegerIsEqual(gTest2initCalled, 2);
}

@end
