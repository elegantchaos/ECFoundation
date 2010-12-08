// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 30/11/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "NSData+ECUtilities.h"



@implementation NSData(ECUtilities)

static unsigned char nibbleToHexChar(unsigned char nibble);

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
// Constants
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
// Methods
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
	
	return string;
}

@end
