//
//  ECLoggingSampleAppDelegate.m
//  ECLoggingSample
//
//  Created by Sam Deane on 28/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ECLoggingSampleAppDelegate.h"
#import "ECLoggingSampleViewController.h"

#import "ECLogging.h"
#import "ECLogManager.h"
#import "ECLogHandlerFile.h"
#import "ECLogHandlerNSLog.h"
#import "ECLogHandlerStdout.h"
#import "ECLogHandlerStderr.h"
#import "ECLogHandlerASL.h"

@interface ECLoggingSampleAppDelegate()


@end

@implementation ECLoggingSampleAppDelegate

#pragma mark - Properties

@synthesize navigationController;
@synthesize window;
@synthesize viewController;


#pragma mark - Channels

ECDefineDebugChannel(ApplicationChannel);


#pragma mark - App Delegate Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    ECLogManager* lm = [ECLogManager sharedInstance];
    [lm startup];

    // install some handlers
    [lm registerHandler:[[[ECLogHandlerNSLog alloc] init] autorelease]];
    [lm registerHandler:[[[ECLogHandlerFile alloc] init] autorelease]];
    [lm registerHandler:[[[ECLogHandlerFile alloc] init] autorelease]];
    [lm registerHandler:[[[ECLogHandlerStdout alloc] init] autorelease]];
    [lm registerHandler:[[[ECLogHandlerStderr alloc] init] autorelease]];
    [lm registerHandler:[[[ECLogHandlerASL alloc] init] autorelease]];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    ECLoggingSampleViewController* view;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
    {
        view = [[ECLoggingSampleViewController alloc] initWithNibName:@"ECLoggingSampleViewController_iPhone" bundle:nil]; 
    }
    else 
    {
        view = [[ECLoggingSampleViewController alloc] initWithNibName:@"ECLoggingSampleViewController_iPad" bundle:nil]; 
    }
    
    self.viewController = view;
    
    UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:view];
    navigation.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController = navigation;

    self.window.rootViewController = navigation;
    [self.window makeKeyAndVisible];

    [view release];
    [navigationController release];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    ECDebug(ApplicationChannel, @"will resign active");
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    ECDebug(ApplicationChannel, @"did enter background");
    [[ECLogManager sharedInstance] saveChannelSettings];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    ECDebug(ApplicationChannel, @"will enter foreground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    ECDebug(ApplicationChannel, @"did become active");
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    ECDebug(ApplicationChannel, @"will terminate");
    
    [[ECLogManager sharedInstance] shutdown];
}

@end
