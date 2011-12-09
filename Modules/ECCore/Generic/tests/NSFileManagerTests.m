// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 09/12/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTestCase.h"
#import "NSFileManager+ECCore.h"

@interface NSFileManagerTests : ECTestCase

@property (nonatomic, assign) NSFileManager* fm;

@end

@implementation NSFileManagerTests

@synthesize fm;

- (void)setUp
{
	self.fm = [NSFileManager defaultManager];
}

- (void)testFileExistsURL
{
	NSURL* url = [self testBundleURL];
	ECTestAssertTrue([self.fm fileExistsAtURL:url]);
	
	BOOL isDirectory = NO;
	ECTestAssertTrue([self.fm fileExistsAtURL:url isDirectory:&isDirectory]);
	ECTestAssertTrue(isDirectory);
}

- (void)testURLS
{
	// test app seems to live in the /usr/bin inside the Xcode folder
	// NB not sure if this will always be true, so this unit test may need changing at some point
	NSString* path = [[self.fm URLForApplication] path];
	ECTestAssertStringEndsWith(path, @"/usr/bin");
	
	// NB not sure if this test will pass for non-English language systems
	path = [[self.fm URLForUserDesktop] path];
	ECTestAssertStringEndsWith(path, @"/Desktop");

	path = [[self.fm URLForApplicationDataPath:@"test app data"] path];
	ECTestAssertStringEndsWith(path, @"/test app data");

	path = [[self.fm URLForCachedDataPath:@"test cached data"] path];
	ECTestAssertStringEndsWith(path, @"test cached data");

}

#if TESTS_STILL_TO_DO

- (BOOL) createDirectoryAtURL: (NSURL*) url withIntermediateDirectories:(BOOL)createIntermediates attributes:(NSDictionary *)attributes error:(NSError **)error;

- (NSURL*)URLForApplication;
- (NSURL*)URLForUserDesktop;
- (NSURL*)URLForApplicationDataPath:(NSString*)path;
- (NSURL*)URLForCachedDataPath:(NSString*)path;
- (NSArray*)URLsForApplicationDataPath:(NSString*)path inDomains:(NSSearchPathDomainMask)domain mode:(URLsForApplicationDataPathMode)mode;
- (NSArray*)URLsForCachedDataPath:(NSString*)path inDomains:(NSSearchPathDomainMask)domain mode:(URLsForApplicationDataPathMode)mode;
- (NSArray*)URLsForDirectory:(NSSearchPathDirectory)directory inDomains:(NSSearchPathDomainMask)domain path:(NSString*)path mode:(URLsForApplicationDataPathMode)mode;
#endif

@end
