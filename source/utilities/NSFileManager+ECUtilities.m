// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 06/03/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "NSFileManager+ECUtilities.h"


@implementation NSFileManager(ECUtilities)

// --------------------------------------------------------------------------
//! Does a URL represent a file or directory?
// --------------------------------------------------------------------------

- (BOOL) fileExistsAtURL:(NSURL*)	url
{
	return [self fileExistsAtPath: [url path]];
}

// --------------------------------------------------------------------------
//! Does a URL represent a file or directory?
//! Also returns whether the item is a directory or a file.
// --------------------------------------------------------------------------

- (BOOL) fileExistsAtURL:(NSURL*)	url isDirectory:(BOOL*) isDirectory
{
	return [self fileExistsAtPath: [url path] isDirectory: isDirectory];
}

// --------------------------------------------------------------------------
//! Create a directory.
// --------------------------------------------------------------------------

- (BOOL)createDirectoryAtURL:(NSURL *)url withIntermediateDirectories:(BOOL)createIntermediates attributes:(NSDictionary *)attributes error:(NSError **)error
{
	return [self createDirectoryAtPath: [url path] withIntermediateDirectories: createIntermediates attributes: attributes error: error];
}

@end
