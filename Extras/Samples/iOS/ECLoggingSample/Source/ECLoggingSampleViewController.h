//
//  ECLoggingSampleViewController.h
//  ECLoggingSample
//
//  Created by Sam Deane on 28/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ECLogViewController;

@interface ECLoggingSampleViewController : UIViewController

@property (nonatomic, retain) IBOutlet ECLogViewController* logView;

- (IBAction)tappedShowDebugView:(id)sender;
- (IBAction)tappedTestOutput:(id)sender;

@end
