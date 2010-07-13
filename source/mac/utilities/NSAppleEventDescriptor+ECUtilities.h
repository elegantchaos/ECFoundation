// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 14/07/2010
//
//! Elegant Chaos extensions to NSAppleEventDescriptor.
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Cocoa/Cocoa.h>


@interface NSAppleEventDescriptor(ECUtilities)

- (NSURL*)		urlValue;
- (NSArray*)	stringArrayValue;
- (NSArray*)	urlArrayValue;

@end
