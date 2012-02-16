//
//  AppDelegate.m
//  ECStyledLabelSample
//
//  Created by Sam Deane on 28/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

#import "ECLogging.h"

@interface AppDelegate()


@end

@implementation AppDelegate

- (UIViewController*)newRootViewController
{
    MainViewController* view = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:view];
    [view release];
    
    return navigation;
}

@end
