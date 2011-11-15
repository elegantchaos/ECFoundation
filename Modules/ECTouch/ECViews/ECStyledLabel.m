// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/10/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECStyledLabel.h"

#import "NSMutableAttributedString+ECCore.h"

#import "UIFont+ECCore.h"

#import "ECMarkdown.h"
#import "ECMarkdownStyles.h"

#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>

@interface ECStyledLabel()


@property (nonatomic, retain) CATextLayer* textLayer;

- (void)makeTextLayer;
- (void)setTestText;

@end

@implementation ECStyledLabel

#pragma mark - Properties

@synthesize scroller;
@synthesize textLayer;

#pragma mark - Channels

ECDefineDebugChannel(StyledLabelChannel);

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]) != nil)
    {
        [self makeTextLayer];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]) != nil)
    {
    }
    
    return self;
}

- (void)awakeFromNib
{
    [self makeTextLayer];
    //    [self setTestText];
}

- (void)dealloc 
{
    [scroller release];
    [textLayer release];
    
    [super dealloc];
}

- (void)setTestText
{
	CTFontRef font = CTFontCreateWithName((CFStringRef) self.font.fontName, self.font.pointSize, NULL);
    NSDictionary* attributes = 
    [NSDictionary dictionaryWithObjectsAndKeys:
     (id) font, (id) kCTFontAttributeName,
     (id) self.textColor.CGColor, (id)kCTForegroundColorAttributeName,
     nil
     ];
  	CFRelease(font);
    
	NSMutableAttributedString* styled = [[NSMutableAttributedString alloc] initWithString:self.text attributes:attributes];
    self.textLayer.string = styled;
    [styled release];
}

- (void)makeTextLayer
{
    CATextLayer* text = [[CATextLayer alloc] init];
    [self.layer addSublayer:text];
    self.textLayer = text;
    [text release];

	CTFontRef font = CTFontCreateWithName((CFStringRef) self.font.fontName, self.font.pointSize, NULL);

	text.frame = self.bounds;
    text.string = self.text;
    text.wrapped = self.numberOfLines != 1;
    text.contentsScale = [[UIScreen mainScreen] scale];
    text.font = font;
    text.foregroundColor = self.textColor.CGColor;
    text.backgroundColor = self.backgroundColor.CGColor;

	CFRelease(font);
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    self.textLayer.string = text;
}

// Measures the height needed for a given width using Core Text:
- (CGSize)textLayerFrameSize
{
    NSAttributedString* string = self.textLayer.string;
    CTTypesetterRef typesetter = CTTypesetterCreateWithAttributedString((CFAttributedStringRef)string);
    CGFloat width = self.bounds.size.width;
    
    CFIndex fullLength = [string length];
    CFIndex offset = 0, length;
    CGFloat y = 0;
    do {
        length = CTTypesetterSuggestLineBreak(typesetter, offset, width);
        CTLineRef line = CTTypesetterCreateLine(typesetter, CFRangeMake(offset, length));
        
        CGFloat ascent, descent, leading;
        CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
        
        CFRelease(line);
        
        offset += length;
        y += ascent + descent + leading;
    } while (offset < fullLength);
    
    CFRelease(typesetter);
    
    return CGSizeMake(width, ceil(y));
}

- (void)sizeToFit
{
    if ([self.textLayer.string isKindOfClass:[NSAttributedString class]])
    {
        CGSize size = [self textLayerFrameSize];
        CGRect frame = self.frame;
        frame.size = size;
        self.frame = frame;
        frame = self.textLayer.frame;
        frame.size = size;
        self.textLayer.frame = frame;
    }
    else
    {
        [super sizeToFit];
    }
}

- (NSAttributedString*)attributedText
{
    return self.textLayer.string;
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setText:[attributedText string]];
    self.textLayer.string = attributedText;
    
    if (self.scroller)
    {
        [self sizeToFit];
        CGSize size = self.frame.size;
        self.scroller.contentSize = size;
    }
}

- (void)drawTextInRect:(CGRect)rect
{
}

- (NSAttributedString*)attributedStringFromMarkdown:(NSString *)markdown
{
    ECMarkdownStyles* styles = [[ECMarkdownStyles alloc] init];
    styles.plainFont = self.font.fontName;
    styles.plainSize = self.font.pointSize;
    styles.boldFont = [self.font boldVariant].fontName;
    styles.headingFont = styles.boldFont;
    styles.headingSize = self.font.pointSize + 2.0;
    styles.colour = self.textColor.CGColor;
    
    NSAttributedString* result = [ECMarkdown attributedStringFromMarkdown:markdown styles:styles];
    [styles release];
    
    return result;
}

@end
