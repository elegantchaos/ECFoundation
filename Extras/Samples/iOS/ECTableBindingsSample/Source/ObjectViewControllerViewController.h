//
//  ObjectViewControllerViewController.h
//  ECTableBindingsSample
//
//  Created by Sam Deane on 14/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ECTSectionDrivenTableController.h"

@class ECTSectionDrivenTableController;

@interface ObjectViewControllerViewController : UIViewController

@property (strong, nonatomic) IBOutlet ECTSectionDrivenTableController* table;

- (void)setupForBinding:(ECTBinding*)binding;

@end
