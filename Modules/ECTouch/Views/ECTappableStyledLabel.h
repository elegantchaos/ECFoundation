// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 09/02/2012
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECStyledLabel.h"


@class ECTappableStyledLabel;

@protocol ECTappableStyledLabelDelegate

@optional

- (void)styledLabel:(ECTappableStyledLabel*)styledLabel didTapIndex:(NSUInteger)index attributes:(NSDictionary*)attributes;
- (void)styledLabel:(ECTappableStyledLabel *)styledLabel didTapLink:(NSString*)link;

@end


@interface ECTappableStyledLabel : ECStyledLabel

@property (assign, nonatomic) IBOutlet id delegate;

@end
