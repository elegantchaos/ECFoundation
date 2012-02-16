// --------------------------------------------------------------------------
//! @author Sam Deane
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTSingleTableViewController.h"

@class ECTSectionDrivenTableController;

@interface MainViewController : ECTSingleTableViewController

@property (strong, nonatomic) IBOutlet UILabel* labelObjects;

- (IBAction)tappedDelete:(id)sender;
- (IBAction)tappedAdd:(id)sender;
- (IBAction)tappedRandomise:(id)sender;
- (IBAction)tappedReplace:(id)sender;

@end
