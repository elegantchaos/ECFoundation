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

#import "NSException+ECCore.h"
#import "NSString+ECCore.h"

@interface NSException_ECCoreTests : ECTestCase

@end

@implementation NSException_ECCoreTests


- (void) testCallstack
{
	@try 
	{
		@throw [NSException exceptionWithName:@"name" reason:@"reason" userInfo:nil];
	}
	@catch (NSException *exception) 
	{
		NSString* stack = [exception stringFromCallstack];
		ECTestAssertStringBeginsWith(stack, @"-[NSException_ECCoreTests testCallstack]");
		NSLog(@"**%@**", stack);
	}
}


@end
