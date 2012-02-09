//
//  ECStyledLabelSampleAppDelegate.m
//  ECStyledLabelSample
//
//  Created by Sam Deane on 28/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ECStyledLabelSampleAppDelegate.h"
#import "ECStyledLabelSampleViewController.h"

#import "ECLogging.h"

@interface ECStyledLabelSampleAppDelegate()


@end

@implementation ECStyledLabelSampleAppDelegate

#pragma mark - Properties


#pragma mark - App Delegate Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    BOOL result = [super application:application didFinishLaunchingWithOptions:launchOptions];
    if (result)
    {
    }

    return YES;
}

- (UIViewController*)newRootViewController
{
    ECStyledLabelSampleViewController* view = [[ECStyledLabelSampleViewController alloc] initWithNibName:@"ECStyledLabelSampleViewController" bundle:nil];
    UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:view];
    [view release];
    
    return [navigation autorelease];
}

@end
