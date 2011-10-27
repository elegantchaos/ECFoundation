// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 05/03/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
//! A semi-transparent round-rectangular view.
// --------------------------------------------------------------------------

@interface ECRoundedView : NSView

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

@property (nonatomic, retain) NSColor* colour;
@property (nonatomic, assign) CGFloat radius;

@end
