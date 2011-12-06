// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 23/09/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECRandom.h"
#import "ECAssertion.h"

@implementation ECRandom

typedef u_int32_t (*uniform_func) (u_int32_t /*upper_bound*/);

static uniform_func gUniformFunc = arc4random_uniform;
static u_int32_t our_uniform_func(u_int32_t upper_bound);

u_int32_t our_uniform_func(u_int32_t upper_bound)
{
	u_int32_t result = arc4random()% (upper_bound + 1);
	
	return result;
}

+ (void)initialize
{
	if (!gUniformFunc)
	{
		gUniformFunc = our_uniform_func;
	}
}

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
	NSInteger result = (NSInteger) gUniformFunc((u_int32_t)to + 1);

    ECAssert(result >= 0);
    ECAssert(result <= to);

    return result;
}

+ (NSInteger)randomIntegerBelow:(NSInteger)to
{
    NSInteger result = (NSInteger) gUniformFunc((u_int32_t)to);
    
    ECAssert(result >= 0);
    ECAssert(result < to);
    
    return result;
}

+ (NSUInteger)randomIndexFromRangeSized:(NSUInteger)size
{
    NSInteger result = (NSInteger) gUniformFunc((u_int32_t)size);

    ECAssert(size > 0);
    ECAssert(result >= 0);
    ECAssert(result < (NSInteger) size);
    
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
        double rand = (double) gUniformFunc((u_int32_t) resolution);
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
    NSInteger rand = (NSInteger) gUniformFunc((u_int32_t)range + 1);
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
