// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 09/12/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTestCase.h"
#import "UIApplication+ECCore.h"

@interface UIApplicationTests : ECTestCase

@end

@implementation UIApplicationTests

- (void)testStrings
{
	// NB app will be nil when running unit tests, so these tests currently don't work
	UIApplication* app = [UIApplication sharedApplication];
	if (app)
	{
		ECTestAssertStringIsEqual([app aboutName], @"");
		ECTestAssertStringIsEqual([app aboutCopyright], @"");
		ECTestAssertStringIsEqual([app aboutVersion], @"");
	}
}

@end
