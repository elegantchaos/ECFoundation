// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 03/02/2012
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <UIKit/UIKit.h>

@interface ECTTabbedTableViewController : UIViewController<UITabBarDelegate>

@property (strong, nonatomic) IBOutlet UITableView* table;
@property (strong, nonatomic) IBOutlet UITabBar* tabs;
@property (strong, nonatomic) NSArray* controllers;

- (void)selectTabWithIndex:(NSUInteger)index;

@end
