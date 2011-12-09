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

@interface UIColorTests : ECTestCase

@end

@implementation UIColorTests

- (void)testIntColor
{
	UIColor* color1 = [UIColor colorWithIntRed:255 green:0 blue:128 alpha:64];
	UIColor* color2 = [UIColor colorWithRed:1.0 green:0.0 blue:0.5 alpha:0.25];
	ECTestAssertTrue([color1 isEqual:color2]);
}

@end
