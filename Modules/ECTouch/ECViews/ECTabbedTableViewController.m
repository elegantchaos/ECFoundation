// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 03/02/2012
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTabbedTableViewController.h"

@interface ECTabbedTableViewController ()
@end

@implementation ECTabbedTableViewController

@synthesize controllers;
@synthesize table;

- (void)dealloc
{
    [controllers release];
    [table release];
    
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.table = nil;
}

#pragma mark - TabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSUInteger index = [tabBar.items indexOfObject:item];
    id<UITableViewDataSource, UITableViewDelegate> controller = [self.controllers objectAtIndex:index];
    self.table.delegate = controller;
    self.table.dataSource = controller;
    [self.table reloadData];
}

@end
