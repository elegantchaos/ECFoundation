// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECLogHandler.h"
#import "ECAssertion.h"

@implementation ECLogHandler

#pragma mark - Properties

@synthesize name;

#pragma mark - Lifecycle

// --------------------------------------------------------------------------
//! Clean up.
// --------------------------------------------------------------------------

- (void)dealloc 
{
    [name release];
    
    [super dealloc];
}

#pragma mark - Logging

// --------------------------------------------------------------------------
//! Log.
// --------------------------------------------------------------------------


- (void) logFromChannel:(ECLogChannel*)channel withFormat:(NSString*)format arguments:(va_list)arguments context:(ECLogContext*)context
{
	ECAssertShouldntBeHere();
}

#pragma mark - Sorting

// --------------------------------------------------------------------------
//! Comparison function for sorting alphabetically by name.
// --------------------------------------------------------------------------

- (NSComparisonResult) caseInsensitiveCompare: (ECLogHandler*) other
{
	return [self.name caseInsensitiveCompare: other.name];
}

@end
