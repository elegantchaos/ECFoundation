// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//! @file:
//! Unit tests for the NSDate+ECUtilitiesTests.h category.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "TestDictionaryBackedObject.h"

@implementation TestDictionaryBackedObject

// --------------------------------------------------------------------------
//! Return the dictionary key to use when looking up object IDs for this class.
//! Subclasses should override this to return a relevant value.
// --------------------------------------------------------------------------

+ (NSString*)objectIDKey
{
    return @"TestID"; // subclasses should override this
}

- (NSString*)name
{
    return [self.data objectForKey:@"TestName"];
}

- (NSString*)text
{
    return [self.data objectForKey:@"TestText"];
}

@end
