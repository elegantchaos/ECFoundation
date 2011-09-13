// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/12/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@interface NSUserDefaults(ECAppKit)

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (NSFont*) fontForKey: (NSString*) key;
- (void) setFont: (NSFont*) font forKey: (NSString*) key;

@end
