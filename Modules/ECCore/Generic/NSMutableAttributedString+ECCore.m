// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 10/10/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "NSMutableAttributedString+ECCore.h"
#import "NSData+ECCore.h"

@implementation NSMutableAttributedString(ECCore)


- (void)matchExpression:(NSRegularExpression*)expression options:(NSRegularExpressionOptions)options reversed:(BOOL)reversed action:(MatchAction)block
{
    NSAttributedString* original = [self copy];
    
    NSRange range = NSMakeRange(0, [self length]);
    NSArray* matches = [expression matchesInString:[self string] options:options range:range];
    NSUInteger count = [matches count];
    if (reversed)
    {
        while (count--)
        {
            block(original, self, [matches objectAtIndex:count]);
        }
    }
    else
    {
		NSUInteger n = 0;
        for (NSTextCheckingResult* match in matches)
        {
            block(original, self, [matches objectAtIndex:n++]);
        }
    }
    
    [original release];
}

- (void)replaceExpression:(NSRegularExpression*)expression options:(NSRegularExpressionOptions)options withIndex:(NSUInteger)index attributes:(NSDictionary*)attributes
{
	[self matchExpression:expression options:options reversed:YES action:
     ^(NSAttributedString* original, NSMutableAttributedString* current, NSTextCheckingResult* match)
     {
		 [current replaceMatch:match withIndex:index attributes:attributes];
     }
     ];

}
- (void)replaceMatch:(NSTextCheckingResult*)match withIndex:(NSUInteger)index attributes:(NSDictionary*)attributes
{
	NSRange whole = [match rangeAtIndex:index];
	NSRange range = [match rangeAtIndex:1];
	NSInteger rangeOffset = range.location - whole.location;
	NSAttributedString* boldText = [self attributedSubstringFromRange:range];
	[self replaceCharactersInRange:whole withAttributedString:boldText];
	range.location -= rangeOffset;
	[self addAttributes:attributes range:range];
}

@end
