// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 22/07/2010
//
//! @file:
//! Logging utilities.
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#define ECDeclareLogChannel(channel)
#define ECDefineLogChannel(channel)
#define ECLog(channel, ...) NSLog(@"«%s» %@", #channel, [NSString stringWithFormat: __VA_ARGS__])
