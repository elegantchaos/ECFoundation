// --------------------------------------------------------------------------
//! @author Sam Deane
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <UIKit/UIKit.h>

@class ECTSectionDrivenTableController;

// --------------------------------------------------------------------------
//! Controller for a view that contains a single section driven
//! table. Typically the view will be defined in a xib, and the
//! section driven table controller will be instantiated there
//! and linked to this controller using IB.
// --------------------------------------------------------------------------

@interface ECTSingleTableViewController : UIViewController

@property (strong, nonatomic) IBOutlet ECTSectionDrivenTableController* table;

@end
