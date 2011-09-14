//
//  NSString+ECCore.m
//  ECFoundation
//
//  Created by Sam Deane on 11/08/2010.
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
//

#import "NSString+ECCore.h"
#import "NSData+ECCore.h"

@implementation NSString(ECCore)


+ (NSString*)stringWithOrdinal:(NSInteger)ordinal
{
    NSString* suffix;
    if (((ordinal >= 4) && (ordinal <= 20)) || ((ordinal >= 24) && (ordinal <= 30)))
    {
        suffix = @"th";
    }
    else
    {
        NSString* suffixes[] = { @"st", @"nd", @"rd" };
        suffix = suffixes[(ordinal % 10) - 1];
    }
    
    NSString* result = [NSString stringWithFormat:@"%d%@", ordinal, suffix];
    return result;
}

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

- (NSString*) stringBySplittingMixedCaps
{
	NSUInteger count = [self length];
	NSMutableString* result = [[NSMutableString alloc] init];
	BOOL wasLower = NO;
	for (NSUInteger n = 0; n < count; ++n)
	{
		UniChar c = [self characterAtIndex: n];
		BOOL isLower = islower(c);
		if (wasLower && !isLower)
		{
			[result appendString: @" "];
		}
		[result appendString: [NSString stringWithCharacters: &c length:1]];
		wasLower = isLower;
	}
	
	return [result autorelease];
}

+ (NSString*)stringWithNewUUID
{
    // Create a new UUID
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    
    // Get the string representation of the UUID
    NSString *newUUID = (NSString*)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return [newUUID autorelease];
}

- (NSString*)sha1Digest
{
	const char *cstr = [self cStringUsingEncoding:NSASCIIStringEncoding];
	return [[NSData dataWithBytes:cstr length:strlen(cstr)] sha1Digest];
}

+ (NSString*)stringByFormattingCount:(NSUInteger)count singularFormat:(NSString*)singularFormat pluralFormat:(NSString*)pluralFormat
{
    NSString* format = (count == 1) ? singularFormat : pluralFormat;
    NSString* result = [NSString stringWithFormat:format, count];

    return result;
}

@end
