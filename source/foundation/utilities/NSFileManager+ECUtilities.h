// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 06/03/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

// --------------------------------------------------------------------------
//! Elegant Chaos extensions to the NSFileManager class.
// --------------------------------------------------------------------------

@interface NSFileManager (ECUtilities)

- (BOOL) fileExistsAtURL:(NSURL*)	url;
- (BOOL) fileExistsAtURL:(NSURL*)	url isDirectory:(BOOL*) isDirectory;

- (BOOL) createDirectoryAtURL: (NSURL*) url withIntermediateDirectories:(BOOL)createIntermediates attributes:(NSDictionary *)attributes error:(NSError **)error;


@end
