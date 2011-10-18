// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//! @file:
//! Logging utilities.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECMacros.h"
#import "ECLogContext.h"


#pragma mark - Plain C interface

// These routines are used in some of the macros, and are generally not intended for public use.


#pragma mark - Channel Declaration Macros

#define ECDeclareLogChannel(channel) \
	extern ECLogChannel* getChannel##channel(void)

#define ECDefineLogChannel(channel) \
	extern ECLogChannel* getChannel##channel(void); \
	ECLogChannel* getChannel##channel(void) \
	{ \
		static ECLogChannel* instance = nil; \
		if (!instance) { instance = registerChannel(#channel); } \
		return instance; \
	}

#pragma mark - Logging Macros

#define ECLog(channel, ...) do { ECLogChannel* c = getChannel##channel(); if (channelEnabled(c)) { ECMakeContext(); logToChannel(c, &ecLogContext, __VA_ARGS__); } } while (0)

#define ECLogIf(test, channel, ...) do { if (test) { ECLogChannel* c = getChannel##channel(); ECMakeContext(); if (channelEnabled(c)) { logToChannel(c, &ecLogContext, __VA_ARGS__); } } } while (0)

#define ECGetChannel(channel) getChannel##channel()

#define ECEnableChannel(channel) enableChannel(getChannel##channel())

#define ECDisableChannel(channel) disableChannel(getChannel##channel())

#define ECChannelEnabled(channel) channelEnabled(getChannel##channel())

#pragma mark - Debug Only Macros

#if EC_DEBUG

#define ECDebug ECLog
#define ECDebugIf ECLogIf
#define ECDefineDebugChannel ECDefineLogChannel
#define ECDeclareDebugChannel ECDeclareLogChannel
#define ECDebugChannelEnabled ECChannelEnabled

#else

#define ECDebug(...) 
#define ECDebugIf(...)
#define ECDefineDebugChannel(...)
#define ECDeclareDebugChannel(...)
#define ECDebugChannelEnabled(channel) (false)

#endif
