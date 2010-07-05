// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 05/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECDropAllViewsAnimation.h"


@implementation ECDropAllViewsAnimation

// --------------------------------------------------------------------------
//! Animate all subviews of a view so that they drop in from the
//! top of the view.
// --------------------------------------------------------------------------

+ (void) animateView: (UIView*) view withDuration: (NSTimeInterval) duration ignoreTag: (NSInteger) tagToIgnore;
{
	// move all subviews off the screen
	NSMutableArray* savedPositions = [[NSMutableArray alloc] init];
	NSArray* subviews = [view subviews];
	for (UIView* subview in subviews)
	{
		if (subview.tag != tagToIgnore)
		{
			CGPoint savedCenter = subview.center;
			[savedPositions addObject: [NSValue valueWithCGPoint: savedCenter]];
			savedCenter.y = -subview.bounds.size.height;
			subview.center = savedCenter;
		}
	}

	// setup the animation
	[UIView beginAnimations:@"AnimateDrop" context:NULL];
	[UIView setAnimationDuration:duration];
	
	// restore original positions of the subviews
	NSUInteger n = 0;
	for (UIView* subview in subviews)
	{
		if (subview.tag != tagToIgnore)
		{
			NSValue* value = [savedPositions objectAtIndex: n++];
			CGPoint savedCenter = [value CGPointValue];
			subview.center = savedCenter;
		}
	}
	
	// start the animation
	[UIView commitAnimations];

	// clean up
	[savedPositions release];	
}

@end
