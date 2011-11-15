// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 23/09/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECRandom.h"

@implementation ECRandom

+ (double)randomDoubleFromZeroTo:(double)to
{
    double result = [ECRandom randomDoubleFrom:0.0 to:to];
    
    ECAssert(result >= 0);
    ECAssert(result <= to);

    return result;
}

+ (double)randomDoubleFromZeroTo:(double)to resolution:(double)resolution
{
    double result = [ECRandom randomDoubleFrom:0.0 to:to resolution:resolution];
    
    ECAssert(result >= 0);
    ECAssert(result <= to);
    
    return result;
}

+ (NSInteger)randomIntegerFromZeroTo:(NSInteger)to
{
    NSInteger result = arc4random_uniform(to + 1);
    
    ECAssert(result >= 0);
    ECAssert(result <= to);

    return result;
}

+ (NSUInteger)randomIndexFromRangeSized:(NSUInteger)size
{
    NSInteger result = arc4random_uniform(size);
    
    ECAssert(size > 0);
    ECAssert(result >= 0);
    ECAssert(result < size);
    
    return result;
}

+ (double)randomDoubleFrom:(double)from to:(double)to
{
    double result = [self randomDoubleFrom:from to:to resolution:0xFFFFFFFF];
    
    ECAssert(result >= from);
    ECAssert(result <= to);
    
    return result;
}

+ (double)randomDoubleFrom:(double)from to:(double)to resolution:(double)resolution
{
    double result;
    if (to > from)
    {
        double range = to - from;
        double mult = range / resolution;
        double rand = arc4random_uniform(resolution);
        result = from + (rand * mult);
        
        ECAssert(result >= from);
        ECAssert(result <= to);
    }
    else
    {
        ECAssert(to == from);
        result = to;
    }

    return result;
}

+ (NSInteger)randomIntegerFrom:(NSInteger)from to:(NSInteger)to
{
    NSInteger range = to - from;
    NSInteger rand = arc4random_uniform(range + 1);
    NSInteger result = from + rand;
    
    ECAssert(result >= from);
    ECAssert(result <= to);
    
    return result;
}

// --------------------------------------------------------------------------
//! Test for a random event.
//! Chance should be from 0.0 to 1.0
// --------------------------------------------------------------------------

+ (BOOL)randomChance:(double)chance
{
    if (chance >= 1.0)
    {
        return YES;
    }
    else if (chance <= 0.0)
    {
        return NO;
    }
    else
    {
        return [self randomDoubleFromZeroTo:1.0] < chance;
    }
}

@end
