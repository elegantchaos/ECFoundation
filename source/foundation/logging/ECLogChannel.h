// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 01/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>


@interface ECLogChannel : NSObject
{
	ECPropertyVariable(enabled, BOOL);
	ECPropertyVariable(name, NSString*);
}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

ECPropertyAssigned(enabled, BOOL);
ECPropertyRetained(name, NSString*);

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (id) initWithRawName: (const char*) name;
- (NSComparisonResult) caseInsensitiveCompare: (ECLogChannel*) other;

@end

