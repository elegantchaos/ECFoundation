// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECSha1.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSData(ECSha1)

// --------------------------------------------------------------------------
//! Return a SHA1 hash of the data.
// --------------------------------------------------------------------------

- (NSString*)sha1Digest
{
	uint8_t digest[CC_SHA1_DIGEST_LENGTH];
	
	CC_SHA1([self bytes], (CC_LONG) [self length], digest);
	
	NSMutableString* outputHolder = [[NSMutableString alloc] initWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
	
	for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
		[outputHolder appendFormat:@"%02x", digest[i]];
	}
	
	NSString *output = [outputHolder copy];
	[outputHolder release];
	
	return [output autorelease];
}

@end

@implementation NSString(ECSha1)

// --------------------------------------------------------------------------
//1 Return SHA1 hash of string.
// --------------------------------------------------------------------------

- (NSString*)sha1Digest
{
	const char *cstr = [self cStringUsingEncoding:NSASCIIStringEncoding];
	return [[NSData dataWithBytes:cstr length:strlen(cstr)] sha1Digest];
}

@end

@implementation NSURL(ECSha1)

// --------------------------------------------------------------------------
//! Return sha1 digest for the file represented by the URL
// --------------------------------------------------------------------------

- (NSString*)sha1Digest
{
	NSString* result;
	NSData* data = [NSData dataWithContentsOfURL:self];
	if (data)
	{
		result = [data sha1Digest];
	}
	else // couldn't get contents, so return sha1 of the url itself
	{
		// TODO - handle directories properly 
		result = [[self absoluteString] sha1Digest];
	}
	
	return result;
}

@end
