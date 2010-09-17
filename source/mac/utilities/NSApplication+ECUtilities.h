// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 08/09/2010
//
//! @file Additional methods for the NSApplication class.
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@interface NSApplication(ECUtilities)

- (BOOL) willStartAtLogin;
- (void) setWillStartAtLogin: (BOOL) enabled;
- (void) setShowsDockIcon: (BOOL) flag;
- (NSURL*) applicationURL;

@end
