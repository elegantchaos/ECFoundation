//
//  AppDelegate.m
//  ECLoggingSampleMac
//
//  Created by Sam Deane on 29/09/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "ECLogManager.h"

@implementation AppDelegate

#pragma mark - Channels

ECDefineDebugChannel(ApplicationChannel);

#pragma mark - Properties

@synthesize window = _window;

#pragma mark - Object Lifecycle

- (void)dealloc
{
    [super dealloc];
}

#pragma mark - Application Lifecycle

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    ECLogManager* lm = [ECLogManager sharedInstance];
    [lm startup];
    [lm registerDefaultHandler];
    
    ECDebug(ApplicationChannel, @"launched");
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
    ECDebug(ApplicationChannel, @"will terminate");
    
    [[ECLogManager sharedInstance] shutdown];
}

- (void)applicationWillResignActive:(NSNotification *)notification
{
    ECDebug(ApplicationChannel, @"will resign active");

    [[ECLogManager sharedInstance] saveChannelSettings];
}

@end
