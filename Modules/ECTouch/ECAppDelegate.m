// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/12/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECAppDelegate.h"

#import "ECAssertion.h"
#import "ECLogging.h"
#import "ECLogManager.h"
#import "ECModelController.h"

@interface ECAppDelegate()
- (void)startupLogging;
- (void)shutdownLogging;
@end

@implementation ECAppDelegate

@synthesize model;
@synthesize window;

ECDefineDebugChannel(ApplicationChannel);

// --------------------------------------------------------------------------
//! Return the normal instance.
// --------------------------------------------------------------------------

+ (ECAppDelegate*)sharedInstance
{
	return [UIApplication sharedApplication].delegate;
}

// --------------------------------------------------------------------------
//! Clean up.
// --------------------------------------------------------------------------

- (void)dealloc 
{
    [model release];
    
    [super dealloc];
}

// --------------------------------------------------------------------------
//! Set up the app after launching.
// --------------------------------------------------------------------------

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    ECDebug(ApplicationChannel, @"did finish launching");
	[self startupLogging];
	
	ECModelController* nm = [self newModel];
	self.model = nm;
	[nm startup];
	[nm load];
	[nm release];

	UIViewController* nrvc = [self newRootViewController];
	UIWindow* nw = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window = nw;
	nw.rootViewController = nrvc;
	[nw makeKeyAndVisible];
	[nrvc release];
	[nw release];
	
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

	[self.model save];
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
    
	[self.model shutdown];
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

#pragma mark - To Be Overridden

// --------------------------------------------------------------------------
//! Create and return the global modal controller.
//! Should be provided by subclass.
// --------------------------------------------------------------------------

- (ECModelController*)newModel
{
    ECModelController* emptyModel = [[ECModelController alloc] init];

	return [emptyModel autorelease];
}

// --------------------------------------------------------------------------
//! Create and return the root view controller.
//! Should be provided by subclass.
// --------------------------------------------------------------------------

- (UIViewController*)newRootViewController
{
	ECAssertShouldntBeHere();
	
	return nil;
}

@end
