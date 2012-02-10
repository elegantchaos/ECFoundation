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

- (void)replaceExpression:(NSRegularExpression*)expression options:(NSRegularExpressionOptions)options atIndex:(NSUInteger)atIndex withIndex:(NSUInteger)withIndex attributes:(NSDictionary *)attributes
{
	[self matchExpression:expression options:options reversed:YES action:
     ^(NSAttributedString* original, NSMutableAttributedString* current, NSTextCheckingResult* match)
     {
		 [current replaceMatch:match atIndex:atIndex withIndex:withIndex attributes:attributes];
     }
     ];

}

- (void)replaceMatch:(NSTextCheckingResult*)match atIndex:(NSUInteger)atIndex withIndex:(NSUInteger)withIndex attributes:(NSDictionary*)attributes
{
    NSMutableDictionary* attributesCopy = [NSMutableDictionary dictionaryWithDictionary:attributes];
    for (NSString* key in attributes)
    {
        id value = [attributes objectForKey:key];
        if ([value isKindOfClass:[NSString class]])
        {
            NSString* string = value;
            if (([string length] > 0) && [string characterAtIndex:0] == '^')
            {
                NSUInteger matchNo = [[string substringFromIndex:1] intValue];
                NSRange matchRange = [match rangeAtIndex:matchNo];
                NSString* matchValue = [[self string] substringWithRange:matchRange];
                [attributesCopy setObject:matchValue forKey:key];
            }
        }
    }

	NSRange whole = [match rangeAtIndex:atIndex];
	NSRange range = [match rangeAtIndex:withIndex];
	NSInteger rangeOffset = range.location - whole.location;
	NSAttributedString* boldText = [self attributedSubstringFromRange:range];
	[self replaceCharactersInRange:whole withAttributedString:boldText];
	range.location -= rangeOffset;
	[self addAttributes:attributesCopy range:range];
}

@end
