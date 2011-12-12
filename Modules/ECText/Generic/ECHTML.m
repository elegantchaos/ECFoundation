// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/10/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECHTML.h"

#import "ECLogging.h"
#import "ECDocumentStyles.h"
#import "ECLogging.h"

#import "NSMutableAttributedString+ECCore.h"

#if EC_PLATFORM_IOS
#import <CoreText/CoreText.h>
#endif

@implementation ECHTML

ECDefineDebugChannel(ECHTMLChannel);

+ (NSAttributedString*)attributedStringFromHTML:(NSString *)html styles:(ECDocumentStyles*)styles
{
    CTFontRef plainFont = CTFontCreateWithName((CFStringRef)styles.plainFont, styles.plainSize, NULL);
    CTFontRef boldFont = CTFontCreateWithName((CFStringRef)styles.boldFont, styles.plainSize, NULL);
    CTFontRef italicFont = CTFontCreateWithName((CFStringRef)styles.italicFont, styles.plainSize, NULL);
    
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

	NSDictionary* italicAttributes = 
    [NSDictionary dictionaryWithObjectsAndKeys:
     (id) italicFont, (id) kCTFontAttributeName,
     nil
     ];

    NSMutableAttributedString* styled = [[NSMutableAttributedString alloc] initWithString:html attributes:attributes];
    
    NSError* error = nil;
    NSRegularExpressionOptions options = NSRegularExpressionCaseInsensitive;
    NSRegularExpression* boldPattern = [NSRegularExpression regularExpressionWithPattern:@"<b>(.*?)</b>" options:options error:&error];
    NSRegularExpression* strongPattern = [NSRegularExpression regularExpressionWithPattern:@"<strong>(.*?)</strong>" options:options error:&error];
    NSRegularExpression* italicPattern = [NSRegularExpression regularExpressionWithPattern:@"<i>(.*?)</i>" options:options error:&error];
    NSRegularExpression* emPattern = [NSRegularExpression regularExpressionWithPattern:@"<em>(.*?)</em>" options:options error:&error];
    
    options = NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators;
    
	[styled replaceExpression:boldPattern options:options withIndex:0 attributes:boldAttributes];
	[styled replaceExpression:strongPattern options:options withIndex:0 attributes:boldAttributes];
	[styled replaceExpression:italicPattern options:options withIndex:0 attributes:italicAttributes];
	[styled replaceExpression:emPattern options:options withIndex:0 attributes:italicAttributes];
    
    CFRelease(plainFont);
    CFRelease(boldFont);
    
    return [styled autorelease];
}

@end
