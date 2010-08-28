// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 01/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECLogChannel.h"
#import "NSString+ECUtilities.h"

static NSString *const kSuffixToStrip = @"Channel";

// --------------------------------------------------------------------------
// Private Methods
// --------------------------------------------------------------------------

@interface ECLogChannel()
- (NSString*) cleanName: (const char*) name;
@end

@implementation ECLogChannel

ECPropertySynthesize(enabled);
ECPropertySynthesize(name);

// --------------------------------------------------------------------------
//! Initialse a channel.
// --------------------------------------------------------------------------

- (id) initWithRawName:(const char *)name
{
	if ((self = [super init]) != nil)
	{
		self.name = [self cleanName: name];
	}
	
	return self;
}

// --------------------------------------------------------------------------
//! Return a cleaned up version of a raw channel name.
// --------------------------------------------------------------------------

- (NSString*) cleanName:(const char *) name;
{
	NSString* temp = [NSString stringWithUTF8String: name];

	if ([temp hasSuffix: kSuffixToStrip])
	{
		temp = [temp substringToIndex: [temp length] - [kSuffixToStrip length]];
	}
	
	return [temp stringBySplittingMixedCaps];
}
// --------------------------------------------------------------------------
//! Clean up and release retained objects.
// --------------------------------------------------------------------------

- (void) dealloc
{
	ECPropertyDealloc(name);
	
	[super dealloc];
}

// --------------------------------------------------------------------------
//! Comparison function for sorting alphabetically by name.
// --------------------------------------------------------------------------

- (NSComparisonResult) caseInsensitiveCompare: (ECLogChannel*) other
{
	return [self.name caseInsensitiveCompare: other.name];
}

@end
