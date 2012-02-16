// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@class ECTBinding;

// --------------------------------------------------------------------------
//! Protocol which can be implemented by any view that
//! displays the object represented by a binding.
//!
//! Typically these are views that are intended to be shown
//! as the disclosure view of a row in a section driven table.
// --------------------------------------------------------------------------

@protocol ECTBindingViewController<NSObject>
- (id)initWithBinding:(ECTBinding*)binding;
- (void)setupForBinding:(ECTBinding*)binding;
@end
