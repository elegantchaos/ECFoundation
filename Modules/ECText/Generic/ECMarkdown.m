// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/10/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECMarkdown.h"

#import "ECLogging.h"
#import "ECDocumentStyles.h"
#import "ECLogging.h"

#import "NSMutableAttributedString+ECCore.h"

#if EC_PLATFORM_IOS
#import <CoreText/CoreText.h>
#endif

@implementation ECMarkdown

ECDefineDebugChannel(ECMarkdownChannel);

+ (NSAttributedString*)attributedStringFromMarkdown:(NSString *)markdown styles:(ECDocumentStyles *)styles
{
    CTFontRef plainFont = CTFontCreateWithName((CFStringRef)styles.plainFont, styles.plainSize, NULL);
    CTFontRef boldFont = CTFontCreateWithName((CFStringRef)styles.boldFont, styles.plainSize, NULL);
    CTFontRef h1Font = CTFontCreateWithName((CFStringRef)styles.headingFont, styles.headingSize, NULL);
    
    NSDictionary* attributes = 
    [NSDictionary dictionaryWithObjectsAndKeys:
     (id) plainFont, (id) kCTFontAttributeName,
     (id) styles.colour, (id)kCTForegroundColorAttributeName,
     nil
     ];
    
    NSDictionary* boldAttributes = 
    [NSDictionary dictionaryWithObjectsAndKeys:
     (id) boldFont, (id) kCTFontAttributeName,
     nil
     ];
    
    NSDictionary* h1Attributes = 
    [NSDictionary dictionaryWithObjectsAndKeys:
     (id) h1Font, (id) kCTFontAttributeName,
     nil
     ];
    
    NSMutableAttributedString* styled = [[NSMutableAttributedString alloc] initWithString:markdown attributes:attributes];
    
    NSError* error = nil;
    NSRegularExpressionOptions options = NSRegularExpressionCaseInsensitive;
    NSRegularExpression* boldPattern = [NSRegularExpression regularExpressionWithPattern:@"\\*(.*?)\\*" options:options error:&error];
    
    options = NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators;
    
    [styled matchExpression:boldPattern options:options reversed:YES action:
     ^(NSAttributedString* original, NSMutableAttributedString* current, NSTextCheckingResult* match)
     {
         NSRange whole = [match rangeAtIndex:0];
         NSRange range = [match rangeAtIndex:1];
         NSInteger rangeOffset = range.location - whole.location;
         NSAttributedString* boldText = [original attributedSubstringFromRange:range];
         [styled replaceCharactersInRange:whole withAttributedString:boldText];
         range.location -= rangeOffset;
         [styled addAttributes:boldAttributes range:range];
     }
     ];
    
    NSRegularExpression* h1Pattern = [NSRegularExpression regularExpressionWithPattern:@"h1\\. (.*?\n)" options:options error:&error];
    [styled matchExpression:h1Pattern options:options reversed:YES action:
     ^(NSAttributedString* original, NSMutableAttributedString* current, NSTextCheckingResult* match)
     {
         NSRange whole = [match rangeAtIndex:0];
         NSRange range = [match rangeAtIndex:1];
         NSInteger rangeOffset = range.location - whole.location;
         NSAttributedString* boldText = [original attributedSubstringFromRange:range];
         [styled replaceCharactersInRange:whole withAttributedString:boldText];
         range.location -= rangeOffset;
         [styled addAttributes:h1Attributes range:range];
     }
     ];
    
    
    CFRelease(plainFont);
    CFRelease(boldFont);
    CFRelease(h1Font);
    
    return [styled autorelease];
}

@end
