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

#pragma mark - Private Interface

@interface ECHTMLParser()

#pragma mark - Private Properties

@property (nonatomic, retain) NSRegularExpression* patternBold;
@property (nonatomic, retain) NSRegularExpression* patternEm;
@property (nonatomic, retain) NSRegularExpression* patternItalic;
@property (nonatomic, retain) NSRegularExpression* patternStrong;

#pragma mark - Private Methods

- (void)initialisePatterns;

@end

@implementation ECHTMLParser

#pragma mark - Properties

@synthesize patternBold;
@synthesize patternEm;
@synthesize patternItalic;
@synthesize patternStrong;

#pragma mark - Debug Channels

ECDefineDebugChannel(ECHTMLChannel);

#pragma mark - Object Lifecycle

// --------------------------------------------------------------------------
//! Initialise with some styles.
// --------------------------------------------------------------------------

- (id)initWithStyles:(ECDocumentStyles *)stylesIn
{
    if ((self = [super initWithStyles:stylesIn]) != nil) 
    {
		[self initialisePatterns];
    }
	
    return self;
}

// --------------------------------------------------------------------------
//! Cleanup.
// --------------------------------------------------------------------------

- (void)dealloc 
{
	[patternBold release];
	[patternEm release];
	[patternItalic release];
	[patternStrong release];
    
    [super dealloc];
}

#pragma mark - HTML

// --------------------------------------------------------------------------
//! Prepare expressions that we'll need.
// --------------------------------------------------------------------------

- (void)initialisePatterns
{
	NSError* error = nil;
	NSRegularExpressionOptions options = NSRegularExpressionCaseInsensitive;
	
	self.patternBold = [NSRegularExpression regularExpressionWithPattern:@"<b>(.*?)</b>" options:options error:&error];
    self.patternStrong = [NSRegularExpression regularExpressionWithPattern:@"<strong>(.*?)</strong>" options:options error:&error];
    self.patternItalic = [NSRegularExpression regularExpressionWithPattern:@"<i>(.*?)</i>" options:options error:&error];
    self.patternEm = [NSRegularExpression regularExpressionWithPattern:@"<em>(.*?)</em>" options:options error:&error];
}

// --------------------------------------------------------------------------
//! Parse some html and return an attributed string.
// --------------------------------------------------------------------------

- (NSAttributedString*)attributedStringFromHTML:(NSString *)html
{
    NSMutableAttributedString* styled = [[NSMutableAttributedString alloc] initWithString:html attributes:self.attributesPlain];
    NSRegularExpressionOptions options = NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators;
    
	[styled replaceExpression:self.patternBold options:options atIndex:0 withIndex:1 attributes:self.attributesBold];
	[styled replaceExpression:self.patternStrong options:options atIndex:0 withIndex:1 attributes:self.attributesBold];
	[styled replaceExpression:self.patternItalic options:options atIndex:0 withIndex:1 attributes:self.attributesItalic];
	[styled replaceExpression:self.patternEm options:options atIndex:0 withIndex:1 attributes:self.attributesItalic];
    
	ECDebug(ECHTMLChannel, @"parsed html %@ into %@", html, styled);
    return [styled autorelease];
}

@end
