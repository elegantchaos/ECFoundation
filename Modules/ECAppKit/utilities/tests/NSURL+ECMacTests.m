// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 13/07/2010.
//
//! @file:
//! Unit tests for the NSURL+ECUtilitiesTests.h category.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "NSURL+ECMacTests.h"
#import "NSURL+ECCoreMac.h"

@implementation NSURL_ECUtilitiesTests


// --------------------------------------------------------------------------
//! Test the getUniqueFileWithName method.
// --------------------------------------------------------------------------

- (void) testGetUniqueFileWithName
{
	NSURL* url = [NSURL URLWithString: @"/Applications/"];
	NSURL* unique = [url getUniqueFileWithName: @"Preview" andExtension: @"app"];
	ECTestAssertNotNil(unique);
	ECTestAssertStringIsEqual([unique path], @"/Applications/Preview 1.app");
	
	unique = [url getUniqueFileWithName: @"Bogus" andExtension: @"bogus"];
	ECTestAssertNotNil(unique);
	ECTestAssertStringIsEqual([unique path], @"/Applications/Bogus.bogus");
}
@end
