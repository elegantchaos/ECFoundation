// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 22/07/2010
//
//! @file:
//! Logging utilities.
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#ifdef __OBJC__

@class ECLogChannel;

#else

typedef void ECLogChannel;

#endif

extern void enableChannel(ECLogChannel* channel);
extern BOOL channelEnabled(ECLogChannel* channel);
extern ECLogChannel* makeNewChannel(const char* name);
extern void	logToChannel(ECLogChannel* channel, NSString* format, ...);

#define ECDeclareLogChannel(channel) \
	extern ECLogChannel* getChannel##channel(void)

#define ECDefineLogChannel(channel) \
	extern ECLogChannel* getChannel##channel(void); \
	ECLogChannel* getChannel##channel(void) \
	{ \
		static ECLogChannel* instance = nil; \
		if (!instance) { instance = makeNewChannel(#channel); } \
		return instance; \
	}

#define ECLog(channel, ...) do { ECLogChannel* c = getChannel##channel(); if (channelEnabled(c)) { logToChannel(c, __VA_ARGS__); } } while (0)

#define ECGetChannel(channel) getChannel##channel()

