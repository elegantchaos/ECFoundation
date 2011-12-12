// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/12/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    ECDebug(ApplicationChannel, @"did finish launching");
	[self startupLogging];
	
	return YES;
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
