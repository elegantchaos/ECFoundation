// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGLAttribute.h"


@implementation ECGLAttribute

// --------------------------------------------------------------------------
//! Properties.
// --------------------------------------------------------------------------

ECPropertySynthesize(name);
ECPropertySynthesize(data);
ECPropertySynthesize(offset);
ECPropertySynthesize(count);
ECPropertySynthesize(index);
ECPropertySynthesize(size);
ECPropertySynthesize(type);
ECPropertySynthesize(normalized);
ECPropertySynthesize(stride);

- (void) dealloc
{
	ECPropertyDealloc(data);
	ECPropertyDealloc(name);
	
	[super dealloc];
}
@end
