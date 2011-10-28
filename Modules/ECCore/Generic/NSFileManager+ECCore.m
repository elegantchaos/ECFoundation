// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "NSFileManager+ECCore.h"

#import "NSArray+ECCore.h"
#import "NSURL+ECCore.h"
#import "ECErrorReporter.h"

@implementation NSFileManager(ECCore)

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
	BOOL result = [self createDirectoryAtPath: [url path] withIntermediateDirectories: createIntermediates attributes: attributes error: error];
    if (!result && error)
    {
        [ECErrorReporter reportError:*error message:@"failed to create directory at @%", url];
    }
    
    return result;
}

// --------------------------------------------------------------------------
//! Return the URL for the user's desktop folder.
// --------------------------------------------------------------------------

- (NSURL*) URLForUserDesktop 
{
    NSError* error = nil;
    NSURL* url = [self URLForDirectory:NSDesktopDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:&error];
    if (!url)
    {
        [ECErrorReporter reportError:error message:@"couldn't get desktop folder location"];
    }
    
    return url;
}

// --------------------------------------------------------------------------
//! Return the URL for some application data.
//! It will always create the folder if it doesn't exist.
// --------------------------------------------------------------------------

- (NSURL*)URLForApplicationDataPath:(NSString*)path
{
	NSArray* paths = [self URLsForApplicationDataPath:path inDomains:NSUserDomainMask mode:MakeMissingItems];
	NSURL* result = [paths firstObjectOrNil];
	
	return result;
}

// --------------------------------------------------------------------------
//! Return the URL for some application data.
//! It will always create the folder if it doesn't exist.
// --------------------------------------------------------------------------

- (NSURL*)URLForCachedDataPath:(NSString *)path
{
	NSArray* paths = [self URLsForCachedDataPath:path inDomains:NSUserDomainMask mode:MakeMissingItems];
	NSURL* result = [paths firstObjectOrNil];
	
	return result;
}

// --------------------------------------------------------------------------
//! Return all URLs for the application's data.
// --------------------------------------------------------------------------

- (NSArray*)URLsForApplicationDataPath:(NSString*)path inDomains:(NSSearchPathDomainMask)domains mode:(URLsForApplicationDataPathMode)mode
{
	return [self URLsForDirectory:NSApplicationSupportDirectory inDomains:domains path:path mode:mode];
}

// --------------------------------------------------------------------------
//! Return all URLs for the application's cache data.
// --------------------------------------------------------------------------

- (NSArray*)URLsForCachedDataPath:(NSString*)path inDomains:(NSSearchPathDomainMask)domains mode:(URLsForApplicationDataPathMode)mode
{
	return [self URLsForDirectory:NSCachesDirectory inDomains:domains path:path mode:mode];
}

// --------------------------------------------------------------------------
//! Return all URLs for a subfolder belonging to the application.
// --------------------------------------------------------------------------

- (NSArray*)URLsForDirectory:(NSSearchPathDirectory)directory inDomains:(NSSearchPathDomainMask)domains path:(NSString*)path mode:(URLsForApplicationDataPathMode)mode
{
	BOOL makeMissing = mode == MakeMissingItems;
	BOOL includeMissing = mode == IncludeMissingItems;
	
	NSError* error = nil;
	NSArray* roots = [self URLsForDirectory:directory inDomains:domains];
	NSMutableArray* result = [NSMutableArray array];
	for (NSURL* root in roots)
	{
		NSString* appId = [[NSBundle mainBundle] bundleIdentifier];
		NSURL* folder = [[root URLByAppendingPathComponent:appId] URLByResolvingLinksAndAliases];
		if (path)
		{
			folder = [[folder URLByAppendingPathComponent:path] URLByResolvingLinksAndAliases];
		}

		BOOL exists = [self fileExistsAtURL:folder];
		if (makeMissing && !exists)
		{
			exists = [self createDirectoryAtURL:folder withIntermediateDirectories:YES attributes:nil error:&error];
		}
		
		if (exists || includeMissing)
		{
			[result addObject:folder];
		}
	}
	
	return result;
}

// --------------------------------------------------------------------------
//! Return the URL for the application.
// --------------------------------------------------------------------------

- (NSURL*)URLForApplication
{
	NSURL* applicationURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
	
	return applicationURL;
}

@end
