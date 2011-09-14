// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@interface NSURL(ECCore)

ECDeclareDebugChannel(NSURLChannel);

+ (NSURL*) URLWithResourceNamed: (NSString*) name ofType: (NSString*) type;
- (id) initWithResourceNamed: (NSString*) name ofType: (NSString*) type;

- (NSURL*)getUniqueFileWithName:(NSString*)name andExtension:(NSString*)extension;
- (NSURL*)getUniqueFileWithName:(NSString*)name andExtension:(NSString*)extension usingManager:(NSFileManager*)fileManager;


@end
