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

- (void)dataTests
{
	NSUInteger value = 0x12345678;
	NSData* data = [NSData dataWithBytes:&value length:sizeof(value)];
	NSString* hex = [data hexString];
	ECTestAssertIsEqualString(hex, @"0x12345678");
}

#if 0
- (NSString*) hexString;
- (NSString*) sha1Digest;
#endif

@end
