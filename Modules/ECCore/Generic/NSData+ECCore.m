// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "NSData+ECCore.h"

#import <CommonCrypto/CommonDigest.h>


@implementation NSData(ECUtilities)

#pragma mark - Prototypes

static unsigned char nibbleToHexChar(unsigned char nibble);

#pragma mark - Internal Utilities

// --------------------------------------------------------------------------
//! Return a hex character (0-9 / A-F), given a nibble
// --------------------------------------------------------------------------

unsigned char nibbleToHexChar(unsigned char nibble)
{
	if (nibble < 10)
	{
		return '0' + nibble;
	}
	else
	{
		return 'A' - 10 + nibble;
	}

}

#pragma mark - Public Methods

// --------------------------------------------------------------------------
//! Return a hex encoded string of the data.
// --------------------------------------------------------------------------

- (NSString*) hexString
{
	NSUInteger length = [self length];
	const unsigned char* buffer = [self bytes];
	NSMutableString* string = [[NSMutableString alloc] initWithCapacity: length * 2];
	
	for (NSUInteger n = 0; n < length; ++n)
	{
		const unsigned char digit = buffer[n];
		[string appendString: [NSString stringWithFormat: @"%c%c", nibbleToHexChar(digit >> 4), nibbleToHexChar(digit & 0xF)]];
	}
	
	return [string autorelease];
}

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
