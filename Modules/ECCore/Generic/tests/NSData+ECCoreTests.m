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

#import "NSData+ECCore.h"
#import "ECTestCase.h"


@interface NSDataTests : ECTestCase

@end

@implementation NSDataTests

- (void)testHexString
{
	unsigned char value[] = { 0x12, 0x34, 0x56, 0x78, 0x9A, 0xBC, 0xDE, 0xF0 };
	NSData* data = [NSData dataWithBytes:&value length:sizeof(value)];
	NSString* hex = [data hexString];
	ECTestAssertIsEqualString(hex, @"123456789ABCDEF0");
}

- (void)testSHA1
{
	unsigned char value[] = { 0x12, 0x34, 0x56, 0x78, 0x9A, 0xBC, 0xDE, 0xF0 };
	NSData* data = [NSData dataWithBytes:&value length:sizeof(value)];
	NSString* sha1 = [data sha1Digest];
	ECTestAssertIsEqualString(sha1, @"2f8084dd1992a0b8aaaef44c93b8bd99de7ffac3");
}

@end
