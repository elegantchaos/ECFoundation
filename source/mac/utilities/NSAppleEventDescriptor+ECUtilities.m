// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 14/07/2010
//
//! Elegant Chaos extensions to NSAppleEventDescriptor.
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "NSAppleEventDescriptor+ECUtilities.h"

@implementation NSAppleEventDescriptor(ECUtilities)

// --------------------------------------------------------------------------
//! Return the value of the descriptor as a URL.
// --------------------------------------------------------------------------

- (NSURL*) urlValue
{
	NSURL* url = nil;
	NSString* string = [self stringValue];
	if (string)
	{
		url = [NSURL URLWithString: string];
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
@end
