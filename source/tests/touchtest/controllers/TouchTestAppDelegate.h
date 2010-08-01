//
//  ECFoundation_TouchTestAppDelegate.h
//  ECFoundation TouchTest
//
//  Created by Sam Deane on 01/08/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface TouchTestAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
	UIWindow *window;

	UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;


@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end

