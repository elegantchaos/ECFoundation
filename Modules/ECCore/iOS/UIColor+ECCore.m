// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 01/08/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "UIColor+ECCore.h"
#import "ECRuntime.h"

@interface UIColor()

- (BOOL)ecGetRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha;

@end


@implementation UIColor(ECCore)

+(void)load
{
	class_replaceMethodIfMissing(self, @selector(getRed:green:blue:alpha:), @selector(ecGetRed:green:blue:alpha:));
}

+ (UIColor*) blueTextColor
{
	return [UIColor colorWithRed:50.0f/255.0f green:79.0f/255.0f blue:133.0f/255.0f alpha:1.0f];
}

+ (UIColor *)colorWithIntRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(NSInteger)alpha
{
    return [UIColor colorWithRed:(CGFloat)red / 255.0f green:(CGFloat)green / 255.0f blue:(CGFloat)blue / 255.0f alpha:(CGFloat)alpha / 255.0f];
}

- (BOOL)ecGetRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha
{
	const CGFloat* components = CGColorGetComponents(self.CGColor);
	BOOL ok = components != nil;
	if (ok)
	{
		*red = components[0];
		*green = components[1];
		*blue = components[2];
		*alpha = components[3];
	}
	
	return ok;
}

@end
