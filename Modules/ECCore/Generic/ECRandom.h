// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 23/09/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@interface ECRandom : NSObject

+ (double)randomDoubleFromZeroTo:(double)to;
+ (double)randomDoubleFromZeroTo:(double)to resolution:(double)resolution;
+ (NSInteger)randomIntegerFromZeroTo:(NSInteger)to;

+ (double)randomDoubleFrom:(double)from to:(double)to;
+ (double)randomDoubleFrom:(double)from to:(double)to resolution:(double)resolution;
+ (NSInteger)randomIntegerFrom:(NSInteger)from to:(NSInteger)to;
+ (NSUInteger)randomIndexFromRangeSized:(NSUInteger)size;
@end