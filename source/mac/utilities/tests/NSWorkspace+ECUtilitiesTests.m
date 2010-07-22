// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/07/2010.
//
//! @file:
//! Unit tests for the NSWorkspace+ECUtilitiesTests.h category.
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "NSWorkspace+ECUtilitiesTests.h"
#import "NSWorkspace+ECUtilities.h"

@implementation NSWorkspace_ECUtilitiesTests

// --------------------------------------------------------------------------
//! Set up before each test.
// --------------------------------------------------------------------------

- (void) setUp
{
	mWorkspace = [NSWorkspace sharedWorkspace];
	mPath = [[NSString alloc] initWithFormat:@"/Applications/Preview.app"];
	mURL = [[NSURL alloc] initWithString: mPath];

}

// --------------------------------------------------------------------------
//! Tear down after each test.
// --------------------------------------------------------------------------

- (void) tearDown
{
	[mURL release];
	[mPath release];
	
	mWorkspace = nil;
	mPath = nil;
	mURL = nil;
}

// --------------------------------------------------------------------------
//! Test NSWorkspace isFilePackageAtURL
// --------------------------------------------------------------------------

- (void) testIsFilePackageAtURL
{
	if (mWorkspace)
	{
		ECTestAssertTrue([mWorkspace isFilePackageAtURL: mURL], @"Preview is a package");
	}
}

// --------------------------------------------------------------------------
//! Test NSWorkspace iconForURL
// --------------------------------------------------------------------------

- (void) testIconForURL
{
	if (mWorkspace)
	{
		NSImage* iconForFile = [mWorkspace iconForFile: mPath];
		ECTestAssertNotNil(iconForFile, @"should get an icon");
		NSImage* iconForURL = [mWorkspace iconForURL: mURL];
		ECTestAssertNotNil(iconForURL, @"should get an icon");
		CGSize sizeForFile = CGSizeMake(iconForFile.size.width, iconForFile.size.height);
		CGSize sizeForURL = CGSizeMake(iconForURL.size.width, iconForURL.size.height);
		ECTestAssertTrue(CGSizeEqualToSize(sizeForFile, sizeForURL), @"icons should be the same");
	}
	
}

@end

