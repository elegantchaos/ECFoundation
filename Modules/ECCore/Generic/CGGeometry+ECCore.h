// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

NS_INLINE CGFloat CGRectGetBottom(CGRect aRect) 
{
    return CGRectGetMaxY(aRect);
}

NS_INLINE CGFloat CGRectGetRight(CGRect aRect) 
{
    return CGRectGetMaxX(aRect);
}

NS_INLINE CGPoint CGRectGetBottomRight(CGRect aRect) 
{
    CGPoint centre = CGPointMake(CGRectGetMaxX(aRect), CGRectGetMaxY(aRect));
    return centre;
}

NS_INLINE CGPoint CGRectGetCentre(CGRect aRect) 
{
    CGPoint centre = CGPointMake(CGRectGetMidX(aRect), CGRectGetMidY(aRect));
    return centre;
}

NS_INLINE CGPoint CGRectGetLocalCentre(CGRect aRect) 
{
    CGPoint centre = CGPointMake(aRect.size.width / 2.0f, aRect.size.height / 2.0f);
    return centre;
}

NS_INLINE CGRect CGRectSetCentre(CGRect aRect, CGPoint centre) 
{
    aRect.origin.x = centre.x - (aRect.size.width * 0.5f);
    aRect.origin.y = centre.y - (aRect.size.height * 0.5f);
    
    return aRect;
}

NS_INLINE CGRect CGRectSetBottomRight(CGRect aRect, CGPoint bottomRight) 
{
    aRect.origin.x = bottomRight.x - aRect.size.width;
    aRect.origin.y = bottomRight.y - aRect.size.height;
    
    return aRect;
}

NS_INLINE CGRect CGRectSetBottom(CGRect aRect, CGFloat bottom) 
{
    aRect.origin.y = bottom - aRect.size.height;
    
    return aRect;
}

NS_INLINE CGRect CGRectSetRight(CGRect aRect, CGFloat right) 
{
    aRect.origin.x = right - aRect.size.width;
    
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
    return (CGFloat) sqrt(CGPointGetDistanceSquared(p1, p2));
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
    return CGPointMake((p1.x + p2.x) / 2.0f, (p1.y + p2.y) / 2.0f);
}

