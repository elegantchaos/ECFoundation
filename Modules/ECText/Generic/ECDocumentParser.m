// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/10/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECDocumentParser.h"

#import "ECLogging.h"
#import "ECDocumentStyles.h"
#import "ECLogging.h"

#import "NSMutableAttributedString+ECCore.h"

#if EC_PLATFORM_IOS
#import <CoreText/CoreText.h>
#endif

@implementation ECDocumentParser

#pragma mark - Properties

@synthesize attributesBold;
@synthesize attributesItalic;
@synthesize attributesPlain;
@synthesize styles;

#pragma mark - Object Lifecycle

// --------------------------------------------------------------------------
//! Initialise with some styles.
// --------------------------------------------------------------------------

- (id)initWithStyles:(ECDocumentStyles *)stylesIn
{
    if ((self = [super init]) != nil) 
    {
        self.styles = stylesIn;
		[self initialiseAttributes];
    }
	
    return self;
}

// --------------------------------------------------------------------------
//! Cleanup.
// --------------------------------------------------------------------------

- (void)dealloc 
{
	[attributesBold release];
	[attributesItalic release];
	[attributesPlain release];
    [styles release];
    
    [super dealloc];
}

#pragma mark - Initialisation

// --------------------------------------------------------------------------
//! Set up some styles we'll need.
// --------------------------------------------------------------------------

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

@end
