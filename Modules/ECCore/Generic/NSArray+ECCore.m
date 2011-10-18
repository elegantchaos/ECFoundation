// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "NSArray+ECCore.h"


@implementation NSArray(ECCore)

- (id)firstObject
{
    id result;
    
    if ([self count])
    {
        result = [self objectAtIndex:0];
    }
    else
    {
        result = nil;
    }
    
    return result;
}

@end
