// --------------------------------------------------------------------------
//! @author Sam Deane
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@class ECModelController;

@interface ECAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) id model;
@property (strong, nonatomic) UIWindow* window;

+ (ECAppDelegate*)sharedInstance;

- (id)newModelController;
- (UIViewController*)newRootViewController;

@end
