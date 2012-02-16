// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 02/02/2012
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <UIKit/UIKit.h>

@protocol ECTPopoverContentController

@property (strong, nonatomic) UIPopoverController* popover;

@optional

- (void)setupWithContent:(id)content;

@end

@interface ECTPopoverContentControllerBase : UIViewController<ECTPopoverContentController>

@property (strong, nonatomic) UIPopoverController* popover;

@end

@interface ECTPopoverContentControllerTable : UITableViewController<ECTPopoverContentController>

@property (strong, nonatomic) UIPopoverController* popover;

@end
