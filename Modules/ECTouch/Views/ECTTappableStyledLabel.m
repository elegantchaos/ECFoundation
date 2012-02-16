// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 09/02/2012
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTTappableStyledLabel.h"
#import "ECLogging.h"
#import "ECDocumentParser.h"

#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>

@interface ECTTappableStyledLabel()

- (void)setup;

@end

@implementation ECTTappableStyledLabel

#pragma mark - Properties

@synthesize delegate;


#pragma mark - Channels

ECDefineDebugChannel(ECTappableStyledLabelChannel);

#pragma mark User Interaction

- (id)initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame:frame]) != nil) 
    {
		[self setup];
	}
    
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]) != nil) 
    {
        [self setup];
    }
    
    return self;
}

- (void)dealloc
{    
    [super dealloc];
}

- (void)setup
{
    [self setUserInteractionEnabled:YES];
}

#if DEBUG_DRAW
- (void)drawRect:(CGRect)rect
{
    //    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext(); 
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 2.0);

    CGRect temp = CGRectMake(0, 0, 100, 100);
    CGContextFillRect(context, temp);
    
    NSAttributedString* attributed = self.attributedText;
    if ([attributed isKindOfClass:[NSAttributedString class]])
    {
        CGMutablePathRef mainPath = CGPathCreateMutable();
        CGPathAddRect(mainPath, NULL, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));  
        
        CTFramesetterRef fs = self.framesetter;
        if (!fs)
        {
            fs = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributed);
            self.framesetter = fs;
        }
        
        CTFrameRef ctframe = CTFramesetterCreateFrame(fs, CFRangeMake(0, 0), mainPath, NULL);
        CGPathRelease(mainPath);
        
        NSArray *lines = (NSArray *)CTFrameGetLines(ctframe);
        NSInteger lineCount = [lines count];
        CGPoint origins[lineCount];
        
        if (lineCount != 0) 
        {
            
            CTFrameGetLineOrigins(ctframe, CFRangeMake(0, 0), origins);
            CGFloat height = CGRectGetHeight(self.frame);
            CGFloat offset = 0;
            for (int i = 0; i < lineCount; i++) 
            {
                CGPoint baselineOrigin = origins[i];
                //the view is inverted, the y origin of the baseline is upside down
                baselineOrigin.y = height - baselineOrigin.y;
                
                CTLineRef line = (CTLineRef)[lines objectAtIndex:i];
                CGFloat ascent, descent, leading;
                CGFloat lineWidth = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
                if (i == 0)
                {
                    offset = baselineOrigin.y - ascent;
                }
                
                CGRect lineFrame = CGRectMake(baselineOrigin.x, (baselineOrigin.y - ascent) - offset, lineWidth, ascent + descent + leading);
                CGContextStrokeRect(context, lineFrame);
            }
        }
        
        CFRelease(ctframe);
    }
}
#endif

- (NSDictionary*)attributesForPoint:(CGPoint)point index:(NSUInteger*)indexOut
{
    NSDictionary* result = nil;
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
        CGFloat lineWidth = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
        
        CGRect lineFrame = CGRectMake(0, y, lineWidth, ascent + descent + leading);
        BOOL inLine = CGRectContainsPoint(lineFrame, point);
        ECDebug(ECTappableStyledLabelChannel, @"line %@ point %@ contained:%d", NSStringFromCGRect(lineFrame), NSStringFromCGPoint(point), inLine);
        if (inLine) 
        {
            //we look if the position of the touch is correct on the line
            CGPoint relativePoint = CGPointMake(point.x, (point.y - y) - ascent);
            ECDebug(ECTappableStyledLabelChannel, @"relative point %@", NSStringFromCGPoint(relativePoint));
            CFIndex index = CTLineGetStringIndexForPosition(line, relativePoint);
            ECDebug(ECTappableStyledLabelChannel, @"index %ld", index);
            result = [string attributesAtIndex:index effectiveRange:nil];
            if (indexOut)
            {
                *indexOut = index;
            }
            break;
        }

        CFRelease(line);
        
        offset += length;
        y += ascent + descent + leading;
    } while (offset < fullLength);
    
    CFRelease(typesetter);
    
    return result;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [(UITouch *)[touches anyObject] locationInView:self];
    NSUInteger index;
    NSDictionary* attributes = [self attributesForPoint:point index:&index];
    if (attributes) 
    {
        ECDebug(ECTappableStyledLabelChannel, @"tapped character index %d with attributes %@", index, attributes);
        if (self.delegate)
        {
            if ([self.delegate respondsToSelector:@selector(styledLabel:didTapIndex:attributes:position:)])
            {
                [self.delegate styledLabel:self didTapIndex:index attributes:attributes position:point];
            }
            
            if ([self.delegate respondsToSelector:@selector(styledLabel:didTapLink:position:)])
            {
                NSString* link = [attributes objectForKey:ECDocumentLinkKey];
                if (link)
                {
                    ECDebug(ECTappableStyledLabelChannel, @"tapped link %@", link);
                    [self.delegate styledLabel:self didTapLink:link position:point];
                }
            }
        }
    }
    else
    {	
        [super touchesEnded:touches withEvent:event];
    }
}


@end
