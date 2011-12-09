// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 09/12/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTestCase.h"
#import "NSURL+ECCore.h"

@interface NSURLTests : ECTestCase

@end

@implementation NSURLTests

- (void)testUniqueFilename
{
	NSURL* unique = [[self testBundleURL] getUniqueFileWithName:@"Info" andExtension:@"plist"];
	ECTestAssertStringIsEqual([unique lastPathComponent], @"Info 1.plist");
}

- (void)testResourceNamed
{
	// can't test this because we have no main bundle in the unit test app
	//	NSURL* url = [NSURL URLWithResourceNamed:@"Test" ofType:@"test"];
	//ECTestAssertStringIsEqual([url lastPathComponent], @"Test.test");
}

- (void)testResolvingLinks
{
	// there's a test link inside the test bundle which links to the bunde's Info.plist
	NSURL* url = [[self testBundleURL] URLByAppendingPathComponent:@"test link"];
	NSURL* resolved = [url URLByResolvingLinksAndAliases];
	ECTestAssertStringIsEqual([resolved lastPathComponent], @"Info.plist");
}

@end
