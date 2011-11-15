// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 24/10/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "NSIndexSet+ECCore.h"

@implementation NSIndexSet(ECCore)

-(NSUInteger)countOfIndexesInRange:(NSRange)range
{
	NSUInteger start, end, count;
	
	if ((range.location == 0) && (range.length == 0))
	{
		return 0;	
	}
	
	start	= range.location;
	end		= start + range.length;
	count	= 0;
	
	NSUInteger currentIndex = [self indexGreaterThanOrEqualToIndex:start];
	
	while ((currentIndex != NSNotFound) && (currentIndex < end))
	{
		count++;
		currentIndex = [self indexGreaterThanIndex:currentIndex];
	}
	
	return count;
}

@end