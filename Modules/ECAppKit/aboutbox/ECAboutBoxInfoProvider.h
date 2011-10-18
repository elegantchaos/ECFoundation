// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 25/02/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@class ECAboutBoxController;

// --------------------------------------------------------------------------
//! Application Info Provider Protocol
//!
//! The application delegate should implement this to provide
//! extra information to the about box.
// --------------------------------------------------------------------------

@protocol ECAboutBoxInfoProvider
	- (NSString*) aboutBox: (ECAboutBoxController*) aboutBox getValueForKey: (NSString*) key;
@end
