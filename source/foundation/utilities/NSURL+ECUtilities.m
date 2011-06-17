// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "NSURL+ECUtilities.h"
#import "NSData+ECUtilities.h"
#import "NSString+ECUtilities.h"

@implementation NSURL(ECUtilities)

// --------------------------------------------------------------------------
//! Get a URL that points at a resource file.
// --------------------------------------------------------------------------

+ (NSURL*) URLWithResourceNamed: (NSString*) name ofType: (NSString*) type
{
	NSURL* url = [[NSURL alloc] initWithResourceNamed: name ofType: type];
	return [url autorelease];
}

// --------------------------------------------------------------------------
//! Initialise a URL to point at a resource file.
// --------------------------------------------------------------------------

- (id) initWithResourceNamed: (NSString*) name ofType: (NSString*) type
{
	NSString* path = [[NSBundle mainBundle] pathForResource: name ofType: type];
	return [self initFileURLWithPath: path isDirectory: NO];
}

// --------------------------------------------------------------------------
//! Return sha1 digest for the file represented by the URL
// --------------------------------------------------------------------------

- (NSString*)sha1Digest
{
	NSString* result;
	NSData* data = [NSData dataWithContentsOfURL:self];
	if (data)
	{
		result = [data sha1Digest];
	}
	else // couldn't get contents, so return sha1 of the url itself
	{
		// TODO - handle directories properly 
		result = [[self absoluteString] sha1Digest];
	}
	
	return result;
}

@end

