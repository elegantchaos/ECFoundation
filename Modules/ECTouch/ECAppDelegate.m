//
//  ECAppDelegate.m
//  ECFoundation
//
//  Created by Sam Deane on 12/12/2011.
//  Copyright (c) 2011 Elegant Chaos. All rights reserved.
//

#import "ECAppDelegate.h"

#import "ECLogging.h"
#import "ECLogManager.h"

@interface ECAppDelegate()
- (void)startupLogging;
- (void)shutdownLogging;
@end

@implementation ECAppDelegate

ECDefineDebugChannel(ApplicationChannel);

// --------------------------------------------------------------------------
//! Set up the app after launching.
// --------------------------------------------------------------------------

- (void) applicationDidFinishLaunching:(UIApplication*)application
{
    ECDebug(ApplicationChannel, @"did finish launching");
	[self startupLogging];
}

// --------------------------------------------------------------------------
//! Handle becoming inactive.
// --------------------------------------------------------------------------

- (void)applicationWillResignActive:(UIApplication *)application 
{
    ECDebug(ApplicationChannel, @"will resign active");
}

// --------------------------------------------------------------------------
//! Handle becoming active again.
// --------------------------------------------------------------------------

- (void)applicationDidBecomeActive:(UIApplication *)application 
{
    ECDebug(ApplicationChannel, @"did become active");
}

// --------------------------------------------------------------------------
//! Handle low memory.
// --------------------------------------------------------------------------

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application 
{
    ECDebug(ApplicationChannel, @"did receive memory warning");
}

// --------------------------------------------------------------------------
//! Handle moving into the background.
// --------------------------------------------------------------------------

-(void) applicationDidEnterBackground:(UIApplication*)application 
{
    ECDebug(ApplicationChannel, @"did enter background");
    [[ECLogManager sharedInstance] saveChannelSettings];
}

// --------------------------------------------------------------------------
//! Handle returning to foreground.
// --------------------------------------------------------------------------

-(void) applicationWillEnterForeground:(UIApplication*)application 
{
    ECDebug(ApplicationChannel, @"will enter foreground");
}

// --------------------------------------------------------------------------
//! Handle app termination.
// --------------------------------------------------------------------------

- (void)applicationWillTerminate:(UIApplication *)application
{
    ECDebug(ApplicationChannel, @"will terminate");
    
    [self shutdownLogging];
}


#pragma mark - Logging

// --------------------------------------------------------------------------
//! Set up standard logging.
// --------------------------------------------------------------------------

- (void)startupLogging
{
    ECLogManager* lm = [ECLogManager sharedInstance];
    [lm startup];
    [lm registerDefaultHandler];
	
}

// --------------------------------------------------------------------------
//! Shut down standard logging.
// --------------------------------------------------------------------------

- (void)shutdownLogging
{
    [[ECLogManager sharedInstance] saveChannelSettings];
    [[ECLogManager sharedInstance] shutdown];
}
@end
