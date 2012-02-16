// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 05/07/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
//! UIScrollView with some extra properties
// --------------------------------------------------------------------------

@interface ECTScrollView : UIScrollView

@property (nonatomic, assign) BOOL swallowTouches;
@property (nonatomic, assign) SEL action;
@property (nonatomic, assign) id target;

@end
