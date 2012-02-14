// --------------------------------------------------------------------------
//! @author Sam Deane
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "AppDelegate.h"
#import "MainViewController.h"
#import "ModelController.h"

@interface AppDelegate()


@end

@implementation AppDelegate

#pragma mark - Propertiess

#pragma mark - App Delegate Methods

+ (AppDelegate*)sharedInstance
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    BOOL result = [super application:application didFinishLaunchingWithOptions:launchOptions];
    if (result)
    {
    }

    return result;
}

- (UIViewController*)newRootViewController
{
    // Override point for customization after application launch.
    MainViewController* view = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil]; 
    UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:view];
    navigation.navigationBar.barStyle = UIBarStyleBlack;
    [view release];

    return navigation;
}

- (ModelController*)newModelController
{
    return [[ModelController alloc] init];
}

@end
