// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "NSFileManager+ECUtilities.h"
#import "ECErrorReporter.h"

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

@end
