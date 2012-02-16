// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "NSArray+ECCore.h"
#import "ECRandom.h"

@implementation NSArray(ECCore)

// --------------------------------------------------------------------------
//! Return the first object in the array, or nil if there are no objects.
// --------------------------------------------------------------------------

- (id)firstObjectOrNil
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

// --------------------------------------------------------------------------
//! Return the last object in the array, or nil if there are no objects.
// --------------------------------------------------------------------------

- (id)lastObjectOrNil
{
    id result;
    
    if ([self count])
    {
        result = [self lastObject];
    }
    else
    {
        result = nil;
    }
    
    return result;
}

@end

@implementation NSMutableArray(ECCore)

// --------------------------------------------------------------------------
//! Array Shuffle
//! http://en.wikipedia.org/wiki/Knuth_shuffle
// --------------------------------------------------------------------------

- (void)randomize 
{
    for(NSUInteger i = [self count]; i > 1; i--) 
    {
        NSUInteger j = [ECRandom randomIntegerBelow: i];
        [self exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
    }
}

// --------------------------------------------------------------------------
//! Move an object.
//! The to index should be the place that the object is to be
//! inserted *once it has been removed*.
// --------------------------------------------------------------------------

- (void)moveObjectFromIndex:(NSUInteger)from toIndex:(NSUInteger)to
{
    id object = [self objectAtIndex:from];
    [self removeObjectAtIndex:from];
    [self insertObject:object atIndex:to];
}

@end
