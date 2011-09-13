// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 13/07/2010.
//
//! @file:
//! Unit tests for the NSAppleEventDescriptor+ECUtilitiesTests.h category.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "NSAppleEventDescriptor+ECUtilitiesTests.h"
#import "NSAppleEventDescriptor+ECAppKit.h"

@implementation NSAppleEventDescriptor_ECUtilitiesTests

// --------------------------------------------------------------------------
//! Test coercing descriptor into a url.
// --------------------------------------------------------------------------

- (void) testURLValue
{
	NSAppleEventDescriptor* desc = [NSAppleEventDescriptor descriptorWithString: @"/Applications/Preview.app"];
	ECTestAssertNotNil(desc, @"should get a valid desc");
	
	NSURL* url = [desc urlValue];
	ECTestAssertTrue([[url path] isEqualToString: @"/Applications/Preview.app"], @"should get same path back");
}

// --------------------------------------------------------------------------
//! Test coercing a descriptor into an NSArray of NSStrings.
// --------------------------------------------------------------------------

- (void) testStringArrayValue
{
	NSAppleEventDescriptor* desc = [NSAppleEventDescriptor listDescriptor];
	ECTestAssertNotNil(desc, @"should get a valid desc");
	[desc insertDescriptor: [NSAppleEventDescriptor descriptorWithString: @"/Test/1.txt"] atIndex: 1];
	[desc insertDescriptor: [NSAppleEventDescriptor descriptorWithString: @"/Test/2.txt"] atIndex: 2];
	ECTestAssertTrue([desc numberOfItems] == 2, @"should have two items");
	
	NSArray* array = [desc stringArrayValue];
	ECTestAssertTrue([array count] == 2, @"should have two items");
	ECTestAssertTrue([[array objectAtIndex: 0] isEqualToString: @"/Test/1.txt"], @"first item should be correct");
	ECTestAssertTrue([[array objectAtIndex: 1] isEqualToString: @"/Test/2.txt"], @"second item should be correct");
}

// --------------------------------------------------------------------------
//! Test coercing a descriptor into an NSArray of NSURLs.
// --------------------------------------------------------------------------

- (void) testURLArrayValue
{
	NSAppleEventDescriptor* desc = [NSAppleEventDescriptor listDescriptor];
	ECTestAssertNotNil(desc, @"should get a valid desc");
	[desc insertDescriptor: [NSAppleEventDescriptor descriptorWithString: @"/Test/1.txt"] atIndex: 1];
	[desc insertDescriptor: [NSAppleEventDescriptor descriptorWithString: @"/Test/2.txt"] atIndex: 2];
	ECTestAssertTrue([desc numberOfItems] == 2, @"should have two items");
	
	NSArray* array = [desc urlArrayValue];
	ECTestAssertTrue([array count] == 2, @"should have two items");
	ECTestAssertTrue([[[array objectAtIndex: 0] path] isEqualToString: @"/Test/1.txt"], @"first item should be correct");
	ECTestAssertTrue([[[array objectAtIndex: 1] path] isEqualToString: @"/Test/2.txt"], @"second item should be correct");
}

@end
