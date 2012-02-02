// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 02/02/2012
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <UIKit/UIKit.h>

@protocol ECPopoverContentController

@property (strong, nonatomic) UIPopoverController* popover;

@end

@interface ECPopoverContentControllerBase : UIViewController<ECPopoverContentController>

@property (strong, nonatomic) UIPopoverController* popover;

@end

@interface ECPopoverContentControllerTable : UITableViewController<ECPopoverContentController>

@property (strong, nonatomic) UIPopoverController* popover;

@end
