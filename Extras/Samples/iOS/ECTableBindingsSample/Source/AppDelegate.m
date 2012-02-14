//
//  ECLoggingSampleAppDelegate.m
//  ECLoggingSample
//
//  Created by Sam Deane on 28/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate()


@end

@implementation AppDelegate

#pragma mark - Propertiess

#pragma mark - App Delegate Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    BOOL result = [super application:application didFinishLaunchingWithOptions:launchOptions];
    if (result)
    {
    }

    return result;
}

- (UIViewController*)newRootController
{
    // Override point for customization after application launch.
    MainViewController* view = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil]; 
    UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:view];
    navigation.navigationBar.barStyle = UIBarStyleBlack;
    [view release];

    return navigation;
}

@end
