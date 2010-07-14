// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 13/07/2010.
//
//! @file:
//! Unit tests for the NSURL+ECUtilitiesTests.h category.
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "NSURL+ECUtilitiesTests.h"
#import "NSURL+ECUtilities.h"

@implementation NSURL_ECUtilitiesTests


// --------------------------------------------------------------------------
//! Test the getUniqueFileWithName method.
// --------------------------------------------------------------------------

- (void) testGetUniqueFileWithName
{
	NSURL* url = [NSURL URLWithString: @"/Applications/"];
	NSURL* unique = [url getUniqueFileWithName: @"Preview" andExtension: @"app"];
	ECTestAssertNotNil(unique, @"should be returned a URL");
	ECTestAssertTrue([[unique path] isEqualToString: @"/Applications/Preview 1.app"], @"file name should be Preview 1.app");
	
	unique = [url getUniqueFileWithName: @"Bogus" andExtension: @"bogus"];
	ECTestAssertNotNil(unique, @"should be returned a URL");
	ECTestAssertTrue([[unique path] isEqualToString: @"/Applications/Bogus.bogus"], @"file name should be Bogus.bogus");
}
@end
