// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/10/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECMarkdownParser.h"

#import "ECLogging.h"
#import "ECDocumentStyles.h"
#import "ECLogging.h"

#import "NSMutableAttributedString+ECCore.h"

#if EC_PLATFORM_IOS
#import <CoreText/CoreText.h>
#endif

#pragma mark - Private Interface

@interface ECMarkdownParser()

#pragma mark - Private Properties

@property (nonatomic, retain) NSDictionary* attributesHeading1;
@property (nonatomic, retain) NSRegularExpression* patternBold;
@property (nonatomic, retain) NSRegularExpression* patternHeading1;

#pragma mark - Private Methods

- (void)initialisePatterns;

@end

@implementation ECMarkdownParser

#pragma mark - Properties

@synthesize attributesHeading1;
@synthesize patternBold;
@synthesize patternHeading1;

#pragma mark - Debug Channels

ECDefineDebugChannel(ECMarkdownChannel);


#pragma mark - Object Lifecycle

// --------------------------------------------------------------------------
//! Init with some styles.
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
	[attributesHeading1 release];
	[patternBold release];
	[patternHeading1 release];
    
    [super dealloc];
}


#pragma mark - Markdown

// --------------------------------------------------------------------------
//! Set up style attributes that we'll need.
// --------------------------------------------------------------------------

- (void)initialiseAttributes
{
	[super initialiseAttributes];
	
	self.attributesHeading1 = 
    [NSDictionary dictionaryWithObjectsAndKeys:
     (id) self.styles.headingFont, (id) kCTFontAttributeName,
     nil
     ];

}

// --------------------------------------------------------------------------
//! Set up regular expression patterns that we'll need.
// --------------------------------------------------------------------------

- (void)initialisePatterns
{
	NSError* error = nil;
	NSRegularExpressionOptions options = NSRegularExpressionCaseInsensitive;
	
	self.patternBold = [NSRegularExpression regularExpressionWithPattern:@"\\*(.*?)\\*" options:options error:&error];
	self.patternHeading1 = [NSRegularExpression regularExpressionWithPattern:@"h1\\. (.*?\n)" options:options error:&error];
}

// --------------------------------------------------------------------------
//! Parse some markdown and return an attributed string.
// --------------------------------------------------------------------------

- (NSAttributedString*)attributedStringFromMarkdown:(NSString*)markdown
{
    NSMutableAttributedString* styled = [[NSMutableAttributedString alloc] initWithString:markdown attributes:self.attributesPlain];
    NSRegularExpressionOptions options = NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators;
    
	[styled replaceExpression:self.patternBold options:options withIndex:0 attributes:self.attributesBold];
	[styled replaceExpression:self.patternHeading1 options:options withIndex:0 attributes:self.attributesHeading1];

    ECDebug(ECMarkdownChannel, @"parsed mardown %@ to %@", markdown, styled);
    return [styled autorelease];
}

@end
