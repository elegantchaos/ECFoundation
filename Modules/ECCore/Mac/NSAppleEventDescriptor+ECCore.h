// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 14/07/2010
//
//! Elegant Chaos extensions to NSAppleEventDescriptor.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Cocoa/Cocoa.h>


@interface NSAppleEventDescriptor(ECCore)

- (NSURL*)urlValue;
- (NSArray*)stringArrayValue;
- (NSArray*)stringArraySortedValue;
- (NSArray*)urlArrayValue;

@end
