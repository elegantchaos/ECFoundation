// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 05/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

@interface ECDropAllViewsAnimation : NSObject 
{

}

+ (void) animateView: (UIView*) view withDuration: (NSTimeInterval) duration ignoreTag: (NSInteger) tagToIgnore;

@end
