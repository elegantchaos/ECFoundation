// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 05/03/2010
//! Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Cocoa/Cocoa.h>

// --------------------------------------------------------------------------
//! A semi-transparent round-rectangular view.
// --------------------------------------------------------------------------

@interface ECRoundedView : NSView
{
	float mTransparency;
	float mRadius;
}

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

@property (assign) float transparency;
@property (assign) float radius;

@end
