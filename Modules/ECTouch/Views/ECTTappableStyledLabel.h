// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 09/02/2012
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTStyledLabel.h"


@class ECTTappableStyledLabel;

@protocol ECTTappableStyledLabelDelegate

@optional

- (void)styledLabel:(ECTTappableStyledLabel*)styledLabel didTapIndex:(NSUInteger)index attributes:(NSDictionary*)attributes position:(CGPoint)position;
- (void)styledLabel:(ECTTappableStyledLabel *)styledLabel didTapLink:(NSString*)link position:(CGPoint)position;

@end


@interface ECTTappableStyledLabel : ECTStyledLabel

@property (assign, nonatomic) IBOutlet id delegate;

@end
