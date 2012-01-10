// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 10/10/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>


@interface NSMutableAttributedString(ECCore)

typedef void(^MatchAction)(NSAttributedString* original, NSMutableAttributedString* current, NSTextCheckingResult* match);

- (void)matchExpression:(NSRegularExpression*)expression options:(NSRegularExpressionOptions)options reversed:(BOOL)reversed action:(MatchAction)block;
- (void)replaceExpression:(NSRegularExpression*)expression options:(NSRegularExpressionOptions)options withIndex:(NSUInteger)index attributes:(NSDictionary*)attributes;
- (void)replaceMatch:(NSTextCheckingResult*)match withIndex:(NSUInteger)index attributes:(NSDictionary*)attributes;

@end
