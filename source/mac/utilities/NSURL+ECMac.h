// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 17/03/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Cocoa/Cocoa.h>


@interface NSURL(ECMac)

- (NSURL*) getUniqueFileWithName: (NSString*) name andExtension: (NSString*) extension;
- (NSURL*) getUniqueFileWithName: (NSString*) name andExtension: (NSString*) extension usingManager: (NSFileManager*) fileManager;

@end
