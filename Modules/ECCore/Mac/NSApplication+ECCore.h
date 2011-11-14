// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 08/09/2010
//
//! @file Additional methods for the NSApplication class.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@interface NSApplication(ECCore)

- (BOOL)willStartAtLogin;
- (void)setWillStartAtLogin: (BOOL) enabled;
- (void)setShowsDockIcon: (BOOL) flag;
- (NSString*)applicationID;
- (NSString*)applicationName;
- (NSString*)applicationVersion;
- (NSString*)applicationBuild;
- (NSString*)applicationCopyright;
- (NSString*)applicationFullVersion;
- (NSString*)licenseFileType;
+ (BOOL)isLionOrGreater;

@end
