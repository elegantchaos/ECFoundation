// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/12/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@class ECModelController;

@interface ECAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) ECModelController* model;
@property (strong, nonatomic) UIWindow* window;

+ (ECAppDelegate*)sharedInstance;

- (ECModelController*)newModel;
- (UIViewController*)newRootViewController;

@end
