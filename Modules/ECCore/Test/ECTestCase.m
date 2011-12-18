// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTestCase.h"

@implementation ECTestCase

// --------------------------------------------------------------------------
//! Return a count for any item that supports the count or length methods.
//! Used in various test assert macros.
// --------------------------------------------------------------------------

+ (NSUInteger)genericCount:(id)item
{
	NSUInteger result;
	
	if ([item respondsToSelector:@selector(length)])
	{
		result = [(NSString*)item length]; // NB doesn't have to be a string, the cast is just there to stop xcode complaining about multiple method signatures
	}
	else if ([item respondsToSelector:@selector(count)])
	{
		result = [(NSArray*)item count]; // NB doesn't have to be an array, the cast is kust there to stop xcode complaining about multiple method signatures
	}
	else
	{
		result = 0;
	}
	
	return result;
}


// --------------------------------------------------------------------------
//! Return file path for a bundle which can be used for file tests.
// --------------------------------------------------------------------------

- (NSString*)testBundlePath
{
	// find test bundle in our resources
	char  buffer[PATH_MAX];
	const char* path = getcwd(buffer, PATH_MAX);
	NSString* result = [NSString stringWithFormat:@"%s/Modules/ECCore/Resources/Tests/Test.bundle", path];
	
	return result;
}

// --------------------------------------------------------------------------
//! Return file URL for a bundle which can be used for file tests.
// --------------------------------------------------------------------------

- (NSURL*)testBundleURL
{
	NSURL* url = [NSURL fileURLWithPath:[self testBundlePath]];
	
	return url;
}

// --------------------------------------------------------------------------
//! Return a bundle which can be used for file tests.
// --------------------------------------------------------------------------

- (NSBundle*)testBundle
{
	NSBundle* bundle = [NSBundle bundleWithPath:[self testBundlePath]];
	
	return bundle;
}

@end
