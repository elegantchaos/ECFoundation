//
//  MainViewController.h
//  ECStyledLabelSample
//
//  Created by Sam Deane on 28/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECTTappableStyledLabel.h"

@class ECTStyledLabel;
@class ECTTappableStyledLabel;

@interface MainViewController : UIViewController<UITextViewDelegate, ECTTappableStyledLabelDelegate>

@property (strong, nonatomic) IBOutlet UITextView* textViewMarkdown;
@property (strong, nonatomic) IBOutlet ECTStyledLabel* labelScrolling;
@property (strong, nonatomic) IBOutlet ECTStyledLabel* labelStyled;
@property (strong, nonatomic) IBOutlet ECTTappableStyledLabel* labelTappable;
- (IBAction)textViewDidChange:(id)sender;

@end
