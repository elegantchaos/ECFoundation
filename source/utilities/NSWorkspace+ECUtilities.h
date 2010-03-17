// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 17/03/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------


@interface NSWorkspace(ECUtilities)

- (BOOL)selectURL:(NSURL*) fullPath inFileViewerRootedAtURL:(NSURL*) rootFullPath;
- (BOOL)isFilePackageAtURL: (NSURL*)fullPath;

@end
