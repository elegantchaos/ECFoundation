// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "CGGeometry+ECCore.h"
#import "ECTestCase.h"


@interface CGGeometry_ECCoreTests : ECTestCase

@end

@implementation CGGeometry_ECCoreTests

static CGRect kTestRect = { 0, 0, 100, 100 };
static CGPoint kTestPoint = { 50, 50 };

- (void)testCGRectGetCentre
{
	ECTestAssertTrue(CGPointEqualToPoint(CGRectGetCentre(kTestRect), kTestPoint));
	ECTestAssertTrue(CGPointEqualToPoint(CGRectGetCentre(CGRectZero), CGPointZero));
}

- (void)testCGRectGetLocalCentre
{
	ECTestAssertTrue(CGPointEqualToPoint(CGRectGetLocalCentre(CGRectZero), CGPointZero));
	
	CGRect test = kTestRect;
	ECTestAssertTrue(CGPointEqualToPoint(CGRectGetLocalCentre(test), kTestPoint));

	test.origin.x += 50;
	test.origin.y += 50;

	ECTestAssertTrue(CGPointEqualToPoint(CGRectGetLocalCentre(test), kTestPoint));
}

#if 0

NS_INLINE CGRect CGRectSetCentre(CGRect aRect, CGPoint centre) 
{
    aRect.origin.x = centre.x - (aRect.size.width * 0.5f);
    aRect.origin.y = centre.y - (aRect.size.height * 0.5f);
    
    return aRect;
}

NS_INLINE CGFloat CGPointGetDistanceSquared(CGPoint p1, CGPoint p2)
{
    CGFloat dx = p1.x - p2.x;
    CGFloat dy = p1.y - p2.y;
    
    return (dx*dx) + (dy*dy);
}

NS_INLINE CGFloat CGPointGetDistance(CGPoint p1, CGPoint p2)
{
    return sqrtf(CGPointGetDistanceSquared(p1, p2));
}

NS_INLINE CGPoint CGPointAdd(CGPoint p1, CGPoint p2)
{
    return CGPointMake(p1.x + p2.x, p1.y + p2.y);
}

NS_INLINE CGPoint CGPointSubtract(CGPoint p1, CGPoint p2)
{
    return CGPointMake(p1.x - p2.x, p1.y - p2.y);
}

NS_INLINE CGPoint CGPointGetMiddle(CGPoint p1, CGPoint p2)
{
    return CGPointMake((p1.x + p2.x) / 2.0f, (p1.y - p2.y) / 2.0f);
}

#endif

@end
