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

ECPropertyAssigned(enabled, BOOL);
ECPropertyRetained(name, NSString*);

@end

