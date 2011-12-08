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
	return @"test2 value";
}

@end

@interface ECLazyPropertiesTest : ECTestCase

@end

@implementation ECLazyPropertiesTest

// --------------------------------------------------------------------------
//! Set up before each test.
// --------------------------------------------------------------------------

- (void) setUp
{
}

// --------------------------------------------------------------------------
//! Tear down after each test.
// --------------------------------------------------------------------------

- (void) tearDown
{
}

// --------------------------------------------------------------------------
//! Test NSDictionary valueForKey: intoBool:
// --------------------------------------------------------------------------

- (void) testFormattedRelative
{
    TestClass* test1 = [[TestClass alloc] init];
    TestClass* test2 = [[TestClass alloc] init];
    
    ECTestAssertTrue([test1.test isEqualToString:@"test value"]);
    test1.test = @"something else";
    ECTestAssertTrue([test1.test isEqualToString:@"something else"]);
    
    ECTestAssertTrue([test2.test isEqualToString:@"test value"]);
    test2.test = @"doodah";
    ECTestAssertTrue([test2.test isEqualToString:@"doodah"]);
	
    [test1 release];
    [test2 release];
}

@end
