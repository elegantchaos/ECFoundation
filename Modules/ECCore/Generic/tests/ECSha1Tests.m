// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//! @file:
//! Unit tests for the NSDate+ECUtilitiesTests.h category.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTestCase.h"
#import "ECSha1.h"

@interface ECSha1Tests : ECTestCase

@end

@implementation ECSha1Tests

- (void)testSHA1Data
{
	unsigned char value[] = { 0x12, 0x34, 0x56, 0x78, 0x9A, 0xBC, 0xDE, 0xF0 };
	NSData* data = [NSData dataWithBytes:&value length:sizeof(value)];
	NSString* sha1 = [data sha1Digest];
	ECTestAssertStringIsEqual(sha1, @"2f8084dd1992a0b8aaaef44c93b8bd99de7ffac3");
}

- (void)testEmptySHA1Data
{
	NSData* data = [NSData data];
	NSString* sha1 = [data sha1Digest];
	ECTestAssertStringIsEqual(sha1, @"da39a3ee5e6b4b0d3255bfef95601890afd80709");
}

- (void)testSHA1String
{
	NSString* sha1 = [@"This is a test string" sha1Digest];
	ECTestAssertStringIsEqual(sha1, @"e2f67c772368acdeee6a2242c535c6cc28d8e0ed");
}

- (void)testEmptySHA1String
{
	NSString* sha1 = [@"" sha1Digest];
	ECTestAssertStringIsEqual(sha1, @"da39a3ee5e6b4b0d3255bfef95601890afd80709");
}

- (void)testSHA1URL
{
	NSString* sha1 = [[NSURL URLWithString:@"http://www.elegantchaos.com"] sha1Digest];
	ECTestAssertStringIsEqual(sha1, @"98401c43d21d0b453dbfe42ecd22ac4d9604869d");
}

- (void)testEmptySHA1URL
{
	NSString* sha1 = [[NSURL URLWithString:@""] sha1Digest];
	ECTestAssertStringIsEqual(sha1, @"da39a3ee5e6b4b0d3255bfef95601890afd80709");
}

@end
