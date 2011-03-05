// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 01/08/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@class ECLogHandler;

@interface ECLogChannel : NSObject
{
	ECPropertyVariable(enabled, BOOL);
	ECPropertyVariable(name, NSString*);
    ECPropertyVariable(handlers, NSMutableArray*);
}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

ECPropertyAssigned(enabled, BOOL);
ECPropertyRetained(name, NSString*);
ECPropertyRetained(handlers, NSMutableArray*);

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (id) initWithName: (NSString*) name;
- (NSComparisonResult) caseInsensitiveCompare: (ECLogChannel*) other;

+ (NSString*) cleanName:(const char *) name;

@end

