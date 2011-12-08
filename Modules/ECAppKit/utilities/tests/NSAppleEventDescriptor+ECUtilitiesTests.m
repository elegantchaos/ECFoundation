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
#import "NSAppleEventDescriptor+ECCore.h"

@implementation NSAppleEventDescriptor_ECUtilitiesTests

// --------------------------------------------------------------------------
//! Test coercing descriptor into a url.
// --------------------------------------------------------------------------

- (void) testURLValue
{
	NSAppleEventDescriptor* desc = [NSAppleEventDescriptor descriptorWithString: @"/Applications/Preview.app"];
	ECTestAssertNotNil(desc);
	
	NSURL* url = [desc urlValue];
	ECTestAssertIsEqualString([url path], @"/Applications/Preview.app");
}

// --------------------------------------------------------------------------
//! Test coercing a descriptor into an NSArray of NSStrings.
// --------------------------------------------------------------------------

- (void) testStringArrayValue
{
	NSAppleEventDescriptor* desc = [NSAppleEventDescriptor listDescriptor];
	ECTestAssertNotNil(desc);
	[desc insertDescriptor: [NSAppleEventDescriptor descriptorWithString: @"/Test/1.txt"] atIndex: 1];
	[desc insertDescriptor: [NSAppleEventDescriptor descriptorWithString: @"/Test/2.txt"] atIndex: 2];
	ECTestAssertIsEqual([desc numberOfItems], 2);
	
	NSArray* array = [desc stringArrayValue];
	ECTestAssertIsEqual([array count], 2);
	ECTestAssertIsEqualString([array objectAtIndex: 0], @"/Test/1.txt");
	ECTestAssertIsEqualString([array objectAtIndex: 1], @"/Test/2.txt");
}

// --------------------------------------------------------------------------
//! Test coercing a descriptor into an NSArray of NSURLs.
// --------------------------------------------------------------------------

- (void) testURLArrayValue
{
	NSAppleEventDescriptor* desc = [NSAppleEventDescriptor listDescriptor];
	ECTestAssertNotNil(desc);
	[desc insertDescriptor: [NSAppleEventDescriptor descriptorWithString: @"/Test/1.txt"] atIndex: 1];
	[desc insertDescriptor: [NSAppleEventDescriptor descriptorWithString: @"/Test/2.txt"] atIndex: 2];
	ECTestAssertIsEqual([desc numberOfItems], 2);
	
	NSArray* array = [desc urlArrayValue];
	ECTestAssertIsEqual([array count], 2);
	ECTestAssertIsEqualString([[array objectAtIndex: 0] path], @"/Test/1.txt");
	ECTestAssertIsEqualString([[array objectAtIndex: 1] path], @"/Test/2.txt");
}

@end
