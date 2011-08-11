// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

// --------------------------------------------------------------------------
//! Elegant Chaos extensions to the NSFileManager class.
// --------------------------------------------------------------------------

@interface NSFileManager (ECUtilities)

- (BOOL) fileExistsAtURL:(NSURL*)	url;
- (BOOL) fileExistsAtURL:(NSURL*)	url isDirectory:(BOOL*) isDirectory;

- (BOOL) createDirectoryAtURL: (NSURL*) url withIntermediateDirectories:(BOOL)createIntermediates attributes:(NSDictionary *)attributes error:(NSError **)error;

- (NSURL*) URLForUserDesktop;

@end
