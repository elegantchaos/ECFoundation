//
//  NSBundle+ECCore.h
//  ECFoundation
//
//  Created by Sam Deane on 13/03/2011.
//  Copyright 2011 Elegant Chaos. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSBundle (ECCore)

// --------------------------------------------------------------------------
//! Return the bundle name of the bundle.
// --------------------------------------------------------------------------

- (NSString*) bundleName;
- (NSString*) bundleVersion;
- (NSString*) bundleBuild;
- (NSString*) bundleFullVersion;
- (NSString*) bundleCopyright;

@end
