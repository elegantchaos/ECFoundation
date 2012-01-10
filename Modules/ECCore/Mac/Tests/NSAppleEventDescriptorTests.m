// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 09/12/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTestCase.h"
#import "NSAppleEventDescriptor+ECCore.h"

@interface NSAppleEventDescriptorTests : ECTestCase

@end

@implementation NSAppleEventDescriptorTests

// --------------------------------------------------------------------------
//! Test coercing descriptor into a url.
// --------------------------------------------------------------------------

- (void) testURLValue
{
	NSAppleEventDescriptor* desc = [NSAppleEventDescriptor descriptorWithString: @"/Applications/Preview.app"];
	ECTestAssertNotNil(desc);
	
	NSURL* url = [desc urlValue];
	ECTestAssertStringIsEqual([url path], @"/Applications/Preview.app");
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
	ECTestAssertIntegerIsEqual([desc numberOfItems], 2);
	
	NSArray* array = [desc stringArrayValue];
	ECTestAssertIntegerIsEqual([array count], 2);
	ECTestAssertStringIsEqual([array objectAtIndex: 0], @"/Test/1.txt");
	ECTestAssertStringIsEqual([array objectAtIndex: 1], @"/Test/2.txt");
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
	ECTestAssertIntegerIsEqual([desc numberOfItems], 2);
	
	NSArray* array = [desc urlArrayValue];
	ECTestAssertIntegerIsEqual([array count], 2);
	ECTestAssertStringIsEqual([[array objectAtIndex: 0] path], @"/Test/1.txt");
	ECTestAssertStringIsEqual([[array objectAtIndex: 1] path], @"/Test/2.txt");
}

@end
