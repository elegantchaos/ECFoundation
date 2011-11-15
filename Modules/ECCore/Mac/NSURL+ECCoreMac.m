// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 17/03/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "NSURL+ECCoreMac.h"

#import "ECLogging.h"
#import "ECMacros.h"
#import "ECErrorReporter.h"
#import "ECAssertion.h"

#import <CoreFoundation/CoreFoundation.h>

@implementation NSURL(ECCoreMac)

// --------------------------------------------------------------------------
//! Make an FSRef representing this URL
//! Just a convenience wrapper for a CFURL routine.
// --------------------------------------------------------------------------

- (BOOL)asFSRef:(FSRef*)ref
{
    ECAssert([self isFileURL]);

    BOOL result = CFURLGetFSRef((CFURLRef) self, ref) != false;
    return result;
}

// --------------------------------------------------------------------------
//! Return an NSURL for the file represented by an FSRef.
//! Just a convenience wrapper for a CFURL routine.
// --------------------------------------------------------------------------

+ (NSURL*)URLWithFSRef:(FSRef*)ref
{
    CFURLRef cfresult = CFURLCreateFromFSRef(kCFAllocatorDefault, ref);
    NSURL* result = (NSURL*) cfresult;
    return [result autorelease];
}

@end

@implementation NSURL(ECCorePlatform)

// --------------------------------------------------------------------------
//! Return a representation of this URL with any symbolic links and Finder
//! aliases fully resolved.
// --------------------------------------------------------------------------

#ifdef EC_DEBUG
#define ECDebugOnly(x) x
#define ECReleaseOnly(x)
#else
#define ECDebugOnly(x)
#define ECReleaseOnly(x) x
#endif

- (NSURL*)URLByResolvingLinksAndAliases
{
    NSURL* result = [self URLByResolvingSymlinksInPath];
    
    ECDebugIf(![result isEqualTo:self], NSURLChannel, @"resolved symbolic link %@ as %@", self, result);

    FSRef ref;
    if ([result asFSRef:&ref])
    {
        Boolean isAlias, isFolder;
        OSStatus status = FSResolveAliasFileWithMountFlags(&ref, true, &isFolder, &isAlias, kResolveAliasFileNoUI);
        if ([ECErrorReporter checkStatus:status] && isAlias)
        {
            NSURL* resolved = [NSURL URLWithFSRef:&ref];
            if (resolved)
            {
                ECDebug(NSURLChannel, @"resolved finder alias %@ as %@", result, resolved);
                result = resolved;
            }
        }
    }

    return result;
}

@end
