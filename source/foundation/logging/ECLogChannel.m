// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 01/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECLogChannel.h"


@implementation ECLogChannel

ECPropertySynthesize(enabled);
ECPropertySynthesize(name);

- (void) dealloc
{
	ECPropertyDealloc(name);
	
	[super dealloc];
}

@end
