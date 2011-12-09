// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 09/12/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTestCase.h"
#import "NSIndexSet+ECCore.h"

@interface NSIndexSetTests : ECTestCase

@end

@implementation NSIndexSetTests

- (void)testCountOfIndexesInRange
{
	NSRange range = NSMakeRange(2, 3);
	NSMutableIndexSet* set = [NSMutableIndexSet indexSetWithIndexesInRange:range];
	// set should contain 2, 3, 4
	
	[set addIndex:1];
	// set should contain 1,2,3,4
	
	[set removeIndex:3];
	// set should contain 1,2,4
	
	// should now be two indexes (2, 4) in the range (2,3,4)
	ECTestAssertTrue([set countOfIndexesInRange:range] == 2);
}

@end
