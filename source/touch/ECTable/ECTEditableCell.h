// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 02/09/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTSimpleCell.h"

@interface ECTEditableCell : ECTSimpleCell<UITextFieldDelegate>

@property (nonatomic, retain) UILabel* label;
@property (nonatomic, retain) UITextField* text;

@end
