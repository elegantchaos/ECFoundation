//
//  NSString+ECUtilities.m
//  ECFoundation
//
//  Created by Sam Deane on 11/08/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//

#import "NSString+ECUtilities.h"


@implementation NSString(ECUtilities)

- (NSData*) splitWordsIntoInts
{
	NSArray* numbers = [self componentsSeparatedByString: @" "];
	NSUInteger count = [numbers count];
	NSMutableData* data = [[NSMutableData alloc] initWithLength: sizeof(int) * count];
	int* buffer = [data mutableBytes];
	for (NSString* index in numbers)
	{
		*buffer++ = [index intValue];
	}
	
	return [data autorelease];
}

- (NSData*) splitWordsIntoFloats
{
	NSArray* numbers = [self componentsSeparatedByString: @" "];
	NSUInteger count = [numbers count];
	NSMutableData* data = [[NSMutableData alloc] initWithLength: sizeof(float) * count];
	float* buffer = [data mutableBytes];
	for (NSString* index in numbers)
	{
		*buffer++ = [index floatValue];
	}

	return [data autorelease];
}

@end
