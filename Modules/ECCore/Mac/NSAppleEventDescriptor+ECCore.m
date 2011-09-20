// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 14/07/2010
//
//! Elegant Chaos extensions to NSAppleEventDescriptor.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "NSAppleEventDescriptor+ECCore.h"

@implementation NSAppleEventDescriptor(ECCore)

// --------------------------------------------------------------------------
//! Return the value of the descriptor as a URL.
// --------------------------------------------------------------------------

- (NSURL*) urlValue
{
	NSURL* url = nil;
	NSString* string = [self stringValue];
	if (string)
	{
		url = [NSURL fileURLWithPath: string];
	}
	
	return url;
}

// --------------------------------------------------------------------------
//! Return the value of the descriptor as an array of strings.
// --------------------------------------------------------------------------

- (NSArray*) stringArrayValue
{
	NSMutableArray* strings = [[[NSMutableArray alloc] init] autorelease];
	
	NSInteger count = [self numberOfItems];
	for (NSInteger index = 1; index <= count; ++index)
	{
		NSAppleEventDescriptor* descriptor = [self descriptorAtIndex: index];
		NSString* string = [[descriptor stringValue] copy];
		[strings addObject: string];
		[string release];
	}
	
	return strings;
}

// --------------------------------------------------------------------------
//! Return the value of the descriptor as an array of URLs.
// --------------------------------------------------------------------------

- (NSArray*) urlArrayValue
{
	NSMutableArray* urls = [[[NSMutableArray alloc] init] autorelease];
	
	NSInteger count = [self numberOfItems];
	for (NSInteger index = 1; index <= count; ++index)
	{
		NSAppleEventDescriptor* descriptor = [self descriptorAtIndex: index];
		NSURL* url = [[NSURL alloc] initWithString: [descriptor stringValue]];
		[urls addObject: url];
		[url release];
	}
	
	return urls;
}

// --------------------------------------------------------------------------
//! Return the value of the descriptor as a sorted array of strings.
// --------------------------------------------------------------------------

- (NSArray*) stringArraySortedValue
{
    NSArray* strings = [self stringArrayValue];
    NSArray* sorted = [strings sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    
    return sorted;
}


@end
