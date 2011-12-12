// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/10/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECHTMLParser.h"

#import "ECLogging.h"
#import "ECDocumentStyles.h"
#import "ECLogging.h"

#import "NSMutableAttributedString+ECCore.h"

#if EC_PLATFORM_IOS
#import <CoreText/CoreText.h>
#endif

@interface ECHTMLParser()
@property (nonatomic, retain) ECDocumentStyles* styles;
@property (nonatomic, retain) NSDictionary* attributesBold;
@property (nonatomic, retain) NSDictionary* attributesItalic;
@property (nonatomic, retain) NSDictionary* attributesPlain;
@property (nonatomic, retain) NSRegularExpression* patternBold;
@property (nonatomic, retain) NSRegularExpression* patternEm;
@property (nonatomic, retain) NSRegularExpression* patternItalic;
@property (nonatomic, retain) NSRegularExpression* patternStrong;


- (void)initialiseAttributes;
- (void)initialisePatterns;

@end

@implementation ECHTMLParser

@synthesize attributesBold;
@synthesize attributesItalic;
@synthesize attributesPlain;
@synthesize patternBold;
@synthesize patternEm;
@synthesize patternItalic;
@synthesize patternStrong;
@synthesize styles;

ECDefineDebugChannel(ECHTMLChannel);

- (id)initWithStyles:(ECDocumentStyles *)stylesIn
{
    if ((self = [super init]) != nil) 
    {
        self.styles = stylesIn;
		[self initialiseAttributes];
		[self initialisePatterns];
    }
	
    return self;
}

- (void)dealloc 
{
	[attributesBold release];
	[attributesItalic release];
	[attributesPlain release];
	
	[patternBold release];
	[patternEm release];
	[patternItalic release];
	[patternStrong release];
	
    [styles release];
    
    [super dealloc];
}

- (void)initialiseAttributes
{
    CTFontRef boldFont = CTFontCreateWithName((CFStringRef)styles.boldFont, styles.plainSize, NULL);
    CTFontRef italicFont = CTFontCreateWithName((CFStringRef)styles.italicFont, styles.plainSize, NULL);
	CTFontRef plainFont = CTFontCreateWithName((CFStringRef)styles.plainFont, styles.plainSize, NULL);
    
    self.attributesPlain = 
    [NSDictionary dictionaryWithObjectsAndKeys:
     (id) plainFont, (id) kCTFontAttributeName,
     (id) styles.colour, (id)kCTForegroundColorAttributeName,
     nil
     ];
    
    self.attributesBold = 
    [NSDictionary dictionaryWithObjectsAndKeys:
     (id) boldFont, (id) kCTFontAttributeName,
     nil
     ];
	
	self.attributesItalic = 
    [NSDictionary dictionaryWithObjectsAndKeys:
     (id) italicFont, (id) kCTFontAttributeName,
     nil
     ];

    CFRelease(boldFont);
    CFRelease(italicFont);
	CFRelease(plainFont);

}

- (void)initialisePatterns
{
	NSError* error = nil;
	NSRegularExpressionOptions options = NSRegularExpressionCaseInsensitive;
	
	self.patternBold = [NSRegularExpression regularExpressionWithPattern:@"<b>(.*?)</b>" options:options error:&error];
    self.patternStrong = [NSRegularExpression regularExpressionWithPattern:@"<strong>(.*?)</strong>" options:options error:&error];
    self.patternItalic = [NSRegularExpression regularExpressionWithPattern:@"<i>(.*?)</i>" options:options error:&error];
    self.patternEm = [NSRegularExpression regularExpressionWithPattern:@"<em>(.*?)</em>" options:options error:&error];
}

- (NSAttributedString*)attributedStringFromHTML:(NSString *)html
{
    NSMutableAttributedString* styled = [[NSMutableAttributedString alloc] initWithString:html attributes:self.attributesPlain];
    NSRegularExpressionOptions options = NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators;
    
	[styled replaceExpression:self.patternBold options:options withIndex:0 attributes:self.attributesBold];
	[styled replaceExpression:self.patternStrong options:options withIndex:0 attributes:self.attributesBold];
	[styled replaceExpression:self.patternItalic options:options withIndex:0 attributes:self.attributesItalic];
	[styled replaceExpression:self.patternEm options:options withIndex:0 attributes:self.attributesItalic];
    
    return [styled autorelease];
}

@end
