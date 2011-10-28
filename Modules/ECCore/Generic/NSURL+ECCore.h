// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECLogging.h"

@interface NSURL(ECCore)

ECDeclareDebugChannel(NSURLChannel);

+ (NSURL*) URLWithResourceNamed: (NSString*) name ofType: (NSString*) type;
- (id) initWithResourceNamed: (NSString*) name ofType: (NSString*) type;
- (NSString*)sha1Digest;
- (NSURL*)getUniqueFileWithName:(NSString*)name andExtension:(NSString*)extension;
- (NSURL*)getUniqueFileWithName:(NSString*)name andExtension:(NSString*)extension usingManager:(NSFileManager*)fileManager;

@end

// These routines are implemented differently on each platform.
// The implementations can be found in NSURL+ECCoreMac.h or NSURL+ECCoreIOS.h
@interface NSURL(ECCorePlatform)
- (NSURL*)URLByResolvingLinksAndAliases;
@end
