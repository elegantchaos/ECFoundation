// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/10/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@class ECStyledLabel;
@class ECScrollView;

@interface ECScrollingStyledLabel : UIView

@property (nonatomic, retain) ECStyledLabel* label;
@property (nonatomic, retain) ECScrollView* scroller;

- (NSAttributedString*)attributedText;
- (void)setAttributedText:(NSAttributedString*)text;

@end
