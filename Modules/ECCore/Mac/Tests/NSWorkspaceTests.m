// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/07/2010.
//
//! @file:
//! Unit tests for the NSWorkspace+ECUtilitiesTests.h category.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTestCase.h"
#import "NSWorkspace+ECCore.h"

@interface NSWorkspaceTests : ECTestCase
{
	NSWorkspace*	mWorkspace;
	NSString*		mPath;
	NSURL*			mURL;
}
@end

@implementation NSWorkspaceTests

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
		ECTestAssertTrue([mWorkspace isFilePackageAtURL: mURL]);
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
		ECTestAssertNotNil(iconForFile);
		NSImage* iconForURL = [mWorkspace iconForURL: mURL];
		ECTestAssertNotNil(iconForURL);
		CGSize sizeForFile = CGSizeMake(iconForFile.size.width, iconForFile.size.height);
		CGSize sizeForURL = CGSizeMake(iconForURL.size.width, iconForURL.size.height);
		ECTestAssertTrue(CGSizeEqualToSize(sizeForFile, sizeForURL));
	}
	
}

@end

