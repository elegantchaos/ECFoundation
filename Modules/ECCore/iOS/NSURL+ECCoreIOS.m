// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 17/03/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "NSURL+ECCore.h"
#import "ECLogging.h"
#import "ECMacros.h"

@implementation NSURL(ECCorePlatform)

// --------------------------------------------------------------------------
//! Return a representation of this URL with any symbolic links
// resolved. On iOS this just calls on to URLByResolvingSymlinksInPath
// since aliases don't exist.
// --------------------------------------------------------------------------

- (NSURL*)URLByResolvingLinksAndAliases
{
    NSURL* result = [self URLByResolvingSymlinksInPath];
	ECDebugIf(![result isEqual:self], NSURLChannel, @"resolved symbolic link %@ as %@", self, result);

    return result;
}

@end
