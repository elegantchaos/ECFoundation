// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

typedef enum
{
	DontIncludeMissingItems,
	IncludeMissingItems,
	MakeMissingItems
} URLsForApplicationDataPathMode;

// --------------------------------------------------------------------------
//! Elegant Chaos extensions to the NSFileManager class.
// --------------------------------------------------------------------------

@interface NSFileManager (ECCore)

- (BOOL) fileExistsAtURL:(NSURL*)	url;
- (BOOL) fileExistsAtURL:(NSURL*)	url isDirectory:(BOOL*) isDirectory;

- (BOOL) createDirectoryAtURL: (NSURL*) url withIntermediateDirectories:(BOOL)createIntermediates attributes:(NSDictionary *)attributes error:(NSError **)error;

- (NSURL*)URLForApplication;
- (NSURL*)URLForUserDesktop;
- (NSURL*)URLForApplicationDataPath:(NSString*)path;
- (NSURL*)URLForCachedDataPath:(NSString*)path;
- (NSURL*)URLForTemporaryDirectory;
- (NSArray*)URLsForApplicationDataPath:(NSString*)path inDomains:(NSSearchPathDomainMask)domain mode:(URLsForApplicationDataPathMode)mode;
- (NSArray*)URLsForCachedDataPath:(NSString*)path inDomains:(NSSearchPathDomainMask)domain mode:(URLsForApplicationDataPathMode)mode;
- (NSArray*)URLsForDirectory:(NSSearchPathDirectory)directory inDomains:(NSSearchPathDomainMask)domain path:(NSString*)path mode:(URLsForApplicationDataPathMode)mode;

@end
