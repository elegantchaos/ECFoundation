// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 24/03/2011
//
//! Elegant Chaos extensions to NSAppleScript.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Cocoa/Cocoa.h>


@interface NSAppleScript(ECCore)

+ (NSAppleScript*) scriptNamed:(NSString*)name;
+ (NSAppleScript*) scriptNamed:(NSString*)name fromBundle:(NSBundle*)bundle;

- (NSAppleEventDescriptor*) callHandler:(NSString*)handlerName withArrayOfParameters:(NSAppleEventDescriptor*) parameterList;
- (NSAppleEventDescriptor*) callHandler:(NSString*)handlerName withParameters:(id)firstParameter, ... NS_REQUIRES_NIL_TERMINATION;

@end
