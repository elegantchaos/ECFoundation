// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 17/03/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "NSURL+ECUtilities.h"


@implementation NSURL(ECUtilities)

// --------------------------------------------------------------------------
//! Get a URL that points at a resource file.
// --------------------------------------------------------------------------

+ (NSURL*) URLWithResourceNamed: (NSString*) name ofType: (NSString*) type
{
	NSURL* url = [[NSURL alloc] initWithResourceNamed: name ofType: type];
	return [url autorelease];
}

// --------------------------------------------------------------------------
//! Initialise a URL to point at a resource file.
// --------------------------------------------------------------------------

- (id) initWithResourceNamed: (NSString*) name ofType: (NSString*) type
{
	NSString* path = [[NSBundle mainBundle] pathForResource: name ofType: type];
	return [self initFileURLWithPath: path isDirectory: NO];
}

@end

