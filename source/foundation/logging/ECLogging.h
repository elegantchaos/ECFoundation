// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 22/07/2010
//
//! @file:
//! Logging utilities.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#ifdef __OBJC__

@class ECLogChannel;

#else

typedef void ECLogChannel;

#endif

#pragma mark - Plain C interface

// These routines are used in some of the macros, and are generally not intended for public use.

extern void enableChannel(ECLogChannel* channel);
extern void disableChannel(ECLogChannel* channel);
extern BOOL channelEnabled(ECLogChannel* channel);
extern ECLogChannel* registerChannel(const char* name);
extern void	logToChannel(ECLogChannel* channel, NSString* format, ...);

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

#define ECLog(channel, ...) do { ECLogChannel* c = getChannel##channel(); if (channelEnabled(c)) { logToChannel(c, __VA_ARGS__); } } while (0)

#define ECGetChannel(channel) getChannel##channel()

#define ECEnableChannel(channel) enableChannel(getChannel##channel())

#define ECDisableChannel(channel) disableChannel(getChannel##channel())

#pragma mark - Debug Only Macros

#if EC_DEBUG

#define ECDebug ECLog
#define ECDefineDebugChannel ECDefineLogChannel

#else

#define ECDebug(...) 
#define ECDefineDebugChannel(...)

#endif
