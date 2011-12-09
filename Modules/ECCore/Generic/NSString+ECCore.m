// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Created by Sam Deane on 11/08/2010.
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

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

- (NSData*) splitWordsIntoDoubles
{
	NSArray* numbers = [self componentsSeparatedByString: @" "];
	NSUInteger count = [numbers count];
	NSMutableData* data = [[NSMutableData alloc] initWithLength: sizeof(double) * count];
	double* buffer = [data mutableBytes];
	for (NSString* index in numbers)
	{
		*buffer++ = [index doubleValue];
	}
	
	return [data autorelease];
}

- (NSArray*)componentsSeparatedByMixedCaps
{
	NSMutableArray* result = [NSMutableArray array];
	NSUInteger count = [self length];
	NSMutableString* word = [[NSMutableString alloc] init];
	BOOL wasLower = NO;
	for (NSUInteger n = 0; n < count; ++n)
	{
		UniChar c = [self characterAtIndex: n];
		BOOL isLower = islower(c);
		if (wasLower && !isLower)
		{
			[result addObject:[NSString stringWithString:word]];
			[word deleteCharactersInRange:NSMakeRange(0, [word length])];
		}
		[word appendString:[NSString stringWithCharacters: &c length:1]];
		wasLower = isLower;
	}
	if ([word length])
	{
		[result addObject:word];
	}
	[word release];
	
	return result;
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

+ (NSString*)stringWithMixedCapsFromWords:(NSArray*)words initialCap:(BOOL)initialCap
{
	NSMutableString* result = [[NSMutableString alloc] init];
	for (NSString* word in words)
	{
		if (initialCap)
		{
			[result appendString:[word capitalizedString]];
		}
		else
		{
			[result appendString:[word lowercaseString]];
			initialCap = YES;
		}
	}
	
	return [result autorelease];
}

+ (NSString*)stringWithUppercaseFromWords:(NSArray*)words separator:(NSString*)separator
{
	NSMutableString* result = [[NSMutableString alloc] init];
	for (NSString* word in words)
	{
		[result appendString:[word uppercaseString]];
		[result appendString:separator];
	}
	
	NSUInteger separatorLength = [separator length];
	[result deleteCharactersInRange:NSMakeRange([result length] - separatorLength, separatorLength)];
	
	return [result autorelease];
}

+ (NSString*)stringWithLowercaseFromWords:(NSArray*)words separator:(NSString*)separator
{
	NSMutableString* result = [[NSMutableString alloc] init];
	for (NSString* word in words)
	{
		[result appendString:[word lowercaseString]];
		[result appendString:separator];
	}
	
	NSUInteger separatorLength = [separator length];
	[result deleteCharactersInRange:NSMakeRange([result length] - separatorLength, separatorLength)];
	
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

+ (NSString*)stringByFormattingCount:(NSUInteger)count singularFormat:(NSString*)singularFormat pluralFormat:(NSString*)pluralFormat
{
    NSString* format = (count == 1) ? singularFormat : pluralFormat;
    NSString* result = [NSString stringWithFormat:format, count];

    return result;
}

- (NSString*)truncateToLength:(NSUInteger)length
{
	NSUInteger actualLength = [self length];
	if (actualLength <= length)
	{
		return self;
	}
	else
	{
		return [NSString stringWithFormat:@"%@…", [self substringToIndex: length - 1]];
	}
}

// --------------------------------------------------------------------------
//! Does this string begin with another string?
//! Returns NO when passed the empty string.
// --------------------------------------------------------------------------

- (BOOL)beginsWithString:(NSString *)string
{
	NSRange range = [self rangeOfString:string];
	
	return range.location == 0;
}

// --------------------------------------------------------------------------
//! Does this string end with another string.
//! Returns NO when passed the empty string.
// --------------------------------------------------------------------------

- (BOOL)endsWithString:(NSString *)string
{
	NSUInteger length = [string length];
	BOOL result = length > 0;
	if (result)
	{
		NSUInteger ourLength = [self length];
		result = (length <= ourLength);
		if (result)
		{
			NSString* substring = [self substringFromIndex:ourLength - length];
			result = [string isEqualToString:substring];
		}
	}

	return result;
}

// --------------------------------------------------------------------------
//! Does this string contain another string?
//! Returns NO when passed the empty string.
// --------------------------------------------------------------------------

- (BOOL)containsString:(NSString *)string
{
	NSRange range = [self rangeOfString:string];
	
	return range.location != NSNotFound;
}


@end
