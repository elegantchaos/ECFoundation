//
//  ECLoggingSampleAppDelegate.h
//  ECLoggingSample
//
//  Created by Sam Deane on 28/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ECLoggingSampleViewController;

@interface ECLoggingSampleAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, retain) UIWindow* window;
@property (nonatomic, retain) ECLoggingSampleViewController* viewController;
@property (nonatomic, retain) UINavigationController* navigationController;

@end
