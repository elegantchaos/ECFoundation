//
//  ECStyledLabelSampleViewController.h
//  ECStyledLabelSample
//
//  Created by Sam Deane on 28/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ECStyledLabel;

@interface ECStyledLabelSampleViewController : UIViewController<UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView*      textViewMarkdown;
@property (strong, nonatomic) IBOutlet ECStyledLabel*   labelScrolling;
@property (strong, nonatomic) IBOutlet ECStyledLabel*   labelStyled;

- (IBAction)textViewDidChange:(id)sender;

@end
