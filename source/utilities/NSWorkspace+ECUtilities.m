// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 17/03/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "NSWorkspace+ECUtilities.h"


@implementation NSWorkspace(ECUtilities)

// --------------------------------------------------------------------------
//! Select an item pointed to by a URL.
// --------------------------------------------------------------------------

- (BOOL)selectURL:(NSURL*) fullPath inFileViewerRootedAtURL:(NSURL*) rootFullPath
{
	return [self selectFile: [fullPath path] inFileViewerRootedAtPath: [rootFullPath path]];
}


- (BOOL)isFilePackageAtURL: (NSURL*) fullPath
{
	return [self isFilePackageAtPath: [fullPath path]];
}

@end
