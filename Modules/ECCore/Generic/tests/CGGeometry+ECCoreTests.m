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

static CGRect kTestRect = { 0.0, 0.0, 100.0, 100.0 };
static CGPoint kTestPoint = { 50.0, 50.0 };

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

	test.origin.x += 50.0;
	test.origin.y += 50.0;

	ECTestAssertTrue(CGPointEqualToPoint(CGRectGetLocalCentre(test), kTestPoint));
}

- (void)testCGRectSetCentre
{
	CGRect test = CGRectSetCentre(kTestRect, CGPointZero);
	ECTestAssertTrue(CGPointEqualToPoint(CGRectGetCentre(test), CGPointZero));
	test = CGRectSetCentre(test, kTestPoint);
	ECTestAssertTrue(CGRectEqualToRect(test, kTestRect));
}

- (void)testCGPointGetDistanceSquared
{
	ECTestAssertRealIsEqual(CGPointGetDistanceSquared(CGPointZero, CGPointZero), 0.0);
	ECTestAssertRealIsEqual(CGPointGetDistanceSquared(CGPointZero, kTestPoint), 5000.0);
}

- (void)testCGPointGetDistance
{
	ECTestAssertRealIsEqual(CGPointGetDistance(CGPointZero, CGPointZero), 0.0);
	ECTestAssertRealIsEqual(CGPointGetDistance(CGPointZero, kTestPoint), sqrt(5000.0));
}

#if 0

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
