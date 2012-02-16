// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/10/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@class CATextLayer;

@interface ECTStyledLabel : UILabel

@property (nonatomic, copy) NSAttributedString* attributedText;
@property (nonatomic, retain) IBOutlet UIScrollView* scroller;
@property (nonatomic, retain) CATextLayer* textLayer;

@end
