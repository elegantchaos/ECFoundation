// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 14/09/2011
//
//! Elegant Chaos extensions to NSColor.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "NSColor+ECCore.h"

@implementation NSColor(ECCore)

+ (NSColor*)colorWithIntRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(NSInteger)alpha
{
    return [NSColor colorWithCalibratedRed:(CGFloat)red / 255.0f green:(CGFloat)green / 255.0f blue:(CGFloat)blue / 255.0f alpha:(CGFloat)alpha / 255.0f];
}

@end
