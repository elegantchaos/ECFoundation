//
//  ObjectViewController.h
//  ECTableBindingsSample
//
//  Created by Sam Deane on 14/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ECTSingleTableViewController.h"
#import "ECTSectionDrivenTableController.h"

@interface ObjectViewController : ECTSingleTableViewController<ECTSectionDrivenTableDisclosureView>

- (void)setupForBinding:(ECTBinding*)binding;

@end
