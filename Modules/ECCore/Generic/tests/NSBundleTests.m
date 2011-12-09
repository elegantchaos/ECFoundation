// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTestCase.h"
#import "NSBundle+ECCore.h"

@interface NSBundleTests : ECTestCase

@end

@implementation NSBundleTests

- (void)testBundleInfo
{
	// find test bundle in our resources
	char  buffer[PATH_MAX];
	const char* path = getcwd(buffer, PATH_MAX);
	NSBundle* bundle = [NSBundle bundleWithPath:[NSString stringWithFormat:@"%s/Modules/ECCore/Resources/Tests/Test.bundle", path]];
	
	ECTestAssertStringIsEqual([bundle bundleName],@"Test Name");
	ECTestAssertStringIsEqual([bundle bundleVersion],@"1.0");
	ECTestAssertStringIsEqual([bundle bundleBuild],@"1");
	ECTestAssertStringIsEqual([bundle bundleFullVersion],@"Version 1.0 (1)");
	ECTestAssertStringIsEqual([bundle bundleCopyright],@"Test Copyright");
}

@end
