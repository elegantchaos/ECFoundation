// --------------------------------------------------------------------------
//! @author Sam Deane
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <UIKit/UIKit.h>

@class ECTSectionDrivenTableController;

@interface MainViewController : UIViewController

@property (strong, nonatomic) IBOutlet ECTSectionDrivenTableController* table;

@end
