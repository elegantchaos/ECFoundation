// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTestCase.h"
#import "NSArray+ECCore.h"

@interface NSArrayTests : ECTestCase

@end

@implementation NSArrayTests

- (void)testFirstObjectOrNil
{
	ECTestAssertTrue([[NSArray array] firstObjectOrNil] == nil);
	ECTestAssertTrue([[NSArray arrayWithObject:@"test"] firstObjectOrNil] == @"test");
	
	NSArray* array = [NSArray arrayWithObjects:@"test1", @"test2", nil];
	ECTestAssertTrue([array firstObjectOrNil] == @"test1");
}

- (void)testRandomize
{
	NSMutableArray* array = [NSMutableArray array];
	[array randomize];
	ECTestAssertIsEmpty(array);
	
	[array addObject:@"test"];
	[array randomize];
	ECTestAssertTrue([array objectAtIndex:0] == @"test");
}

@end
