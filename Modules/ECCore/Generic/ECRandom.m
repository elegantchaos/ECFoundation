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
    NSInteger result = (NSInteger) arc4random_uniform((u_int32_t)to + 1);
    
    ECAssert(result >= 0);
    ECAssert(result <= to);

    return result;
}

+ (NSUInteger)randomIndexFromRangeSized:(NSUInteger)size
{
    NSInteger result = (NSInteger) arc4random_uniform((u_int32_t)size);
    
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
    double range = to - from;
    double mult = range / resolution;
    double rand = arc4random_uniform(resolution);
    double result = from + (rand * mult);
    
    ECAssert(result >= from);
    ECAssert(result <= to);

    return result;
}

+ (NSInteger)randomIntegerFrom:(NSInteger)from to:(NSInteger)to
{
    NSInteger range = to - from;
    NSInteger rand = (NSInteger) arc4random_uniform((u_int32_t)range + 1);
    NSInteger result = from + rand;
    
    ECAssert(result >= from);
    ECAssert(result <= to);
    
    return result;
}

@end
