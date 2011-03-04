// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 01/08/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECLogChannel.h"
#import "NSString+ECUtilities.h"

static NSString *const kSuffixToStrip = @"Channel";

// --------------------------------------------------------------------------
// Private Methods
// --------------------------------------------------------------------------

@interface ECLogChannel()
@end

@implementation ECLogChannel

ECPropertySynthesize(enabled);
ECPropertySynthesize(name);

// --------------------------------------------------------------------------
//! Initialse a channel.
// --------------------------------------------------------------------------

- (id) initWithName:(NSString*)name
{
	if ((self = [super init]) != nil)
	{
		self.name = name;
	}
	
	return self;
}

// --------------------------------------------------------------------------
//! Return a cleaned up version of a raw channel name.
// --------------------------------------------------------------------------

+ (NSString*) cleanName:(const char *) name;
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
