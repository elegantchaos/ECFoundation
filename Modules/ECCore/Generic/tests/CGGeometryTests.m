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


@interface CGGeometryTests : ECTestCase

@end

@implementation CGGeometryTests

static CGRect kTestRect = { (CGFloat) 0.0, (CGFloat) 0.0, (CGFloat) 100.0, (CGFloat) 100.0 };
static CGPoint kTestPoint = { (CGFloat) 100.0, (CGFloat) 100.0 };
static CGPoint kTestMiddle = { (CGFloat) 50.0, (CGFloat) 50.0 };

- (void)testCGRectGetCentre
{
	ECTestAssertTrue(CGPointEqualToPoint(CGRectGetCentre(kTestRect), kTestMiddle));
	ECTestAssertTrue(CGPointEqualToPoint(CGRectGetCentre(CGRectZero), CGPointZero));
}

- (void)testCGRectGetLocalCentre
{
	ECTestAssertTrue(CGPointEqualToPoint(CGRectGetLocalCentre(CGRectZero), CGPointZero));
	
	CGRect test = kTestRect;
	ECTestAssertTrue(CGPointEqualToPoint(CGRectGetLocalCentre(test), kTestMiddle));

	test.origin.x += (CGFloat) 50.0;
	test.origin.y += (CGFloat) 50.0;

	ECTestAssertTrue(CGPointEqualToPoint(CGRectGetLocalCentre(test), kTestMiddle));
}

- (void)testCGRectSetCentre
{
	CGRect test = CGRectSetCentre(kTestRect, CGPointZero);
	ECTestAssertTrue(CGPointEqualToPoint(CGRectGetCentre(test), CGPointZero));
	test = CGRectSetCentre(test, kTestMiddle);
	ECTestAssertTrue(CGRectEqualToRect(test, kTestRect));
}

- (void)testCGPointGetDistanceSquared
{
	ECTestAssertRealIsEqual(CGPointGetDistanceSquared(CGPointZero, CGPointZero), 0.0);
	ECTestAssertRealIsEqual(CGPointGetDistanceSquared(CGPointZero, kTestPoint), 20000.0);
}

- (void)testCGPointGetDistance
{
	ECTestAssertRealIsEqual(CGPointGetDistance(CGPointZero, CGPointZero), 0.0);
	ECTestAssertRealIsEqual(CGPointGetDistance(CGPointZero, kTestPoint), (CGFloat) sqrt(20000.0));
}

- (void)testCGPointAdd
{
	ECTestAssertTrue(CGPointEqualToPoint(CGPointAdd(CGPointZero, kTestPoint), kTestPoint));
	ECTestAssertTrue(CGPointEqualToPoint(CGPointAdd(kTestPoint, CGPointZero), kTestPoint));
	ECTestAssertTrue(CGPointEqualToPoint(CGPointAdd(kTestMiddle, kTestMiddle), kTestPoint));
}

- (void)testCGPointSubtract
{
	ECTestAssertTrue(CGPointEqualToPoint(CGPointSubtract(kTestPoint, CGPointZero), kTestPoint));
	ECTestAssertTrue(CGPointEqualToPoint(CGPointSubtract(kTestPoint, kTestPoint), CGPointZero));
}

- (void)testCGPointGetMiddle
{
	ECTestAssertTrue(CGPointEqualToPoint(CGPointGetMiddle(CGPointZero, CGPointZero), CGPointZero));
	ECTestAssertTrue(CGPointEqualToPoint(CGPointGetMiddle(CGPointZero, kTestPoint), kTestMiddle));
}

@end
