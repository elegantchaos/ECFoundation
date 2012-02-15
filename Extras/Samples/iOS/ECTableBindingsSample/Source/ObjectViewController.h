// --------------------------------------------------------------------------
//! @author Sam Deane
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTSingleTableViewController.h"
#import "ECTSectionDrivenTableController.h"

@interface ObjectViewController : ECTSingleTableViewController<ECTSectionDrivenTableDisclosureView>

- (void)setupForBinding:(ECTBinding*)binding;

@end
