// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 09/12/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTestCase.h"
#import "UIColor+ECCore.h"

#import <QuartzCore/QuartzCore.h>

@interface UIColorTests : ECTestCase

@end

@implementation UIColorTests

- (void)testIntColor
{
	UIColor* color1 = [UIColor colorWithIntRed:255 green:0 blue:127 alpha:64];
	CGFloat r,g,b,a;
	if ([color1 respondsToSelector:@selector(getRed:green:blue:alpha:)])
	{
		[color1 getRed:&r green:&g blue:&b alpha:&a];
	}
	else
	{
		const CGFloat* components = CGColorGetComponents(color1.CGColor);
		r = components[0];
		g = components[1];
		b = components[2];
		a = components[3];
	}
	
	ECTestAssertRealIsEqual(r, 1.0);
	ECTestAssertRealIsEqual(g, 0);
	ECTestAssertRealIsEqual(b, (CGFloat) 127.0 / (CGFloat) 255.0);
	ECTestAssertRealIsEqual(a, (CGFloat) 64.0 / (CGFloat) 255.0);
}

@end
