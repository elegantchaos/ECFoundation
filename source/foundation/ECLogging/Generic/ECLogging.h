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

#ifdef __OBJC__

@class ECLogChannel;

#else

typedef void ECLogChannel;

#endif

#pragma mark - Plain C interface

// These routines are used in some of the macros, and are generally not intended for public use.

#ifdef __cplusplus
extern "C"
{
#endif

    typedef struct 
    {
        const char* file;
        unsigned int line;
        const char* date;
        const char* function;
    } ECLogContext;
    
    extern void makeContext(ECLogContext* context, const char* file, unsigned int line, const char* date, const char* function);
    extern void enableChannel(ECLogChannel* channel);
    extern void disableChannel(ECLogChannel* channel);
    extern BOOL channelEnabled(ECLogChannel* channel);
    extern ECLogChannel* registerChannel(const char* name);
    extern void	logToChannel(ECLogChannel* channel, ECLogContext* context, NSString* format, ...);

#ifdef __cplusplus
}
#endif

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

#define ECMakeContext() ECLogContext context; makeContext(&context, __FILE__, __LINE__, __DATE__, __PRETTY_FUNCTION__)

#define ECLog(channel, ...) do { ECLogChannel* c = getChannel##channel(); if (channelEnabled(c)) { ECMakeContext(); logToChannel(c, &context, __VA_ARGS__); } } while (0)

#define ECLogIf(test, channel, ...) do { if (test) { ECLogChannel* c = getChannel##channel(); ECMakeContext(); if (channelEnabled(c)) { logToChannel(c, &context, __VA_ARGS__); } } } while (0)

#define ECGetChannel(channel) getChannel##channel()

#define ECEnableChannel(channel) enableChannel(getChannel##channel())

#define ECDisableChannel(channel) disableChannel(getChannel##channel())

#define ECChannelEnabled(channel) channelEnabled(getChannel##channel())

#pragma mark - Debug Only Macros

#if EC_DEBUG

#define ECDebug ECLog
#define ECDebugIf ECLogIf
#define ECDefineDebugChannel ECDefineLogChannel
#define ECDebugChannelEnabled ECChannelEnabled

#else

#define ECDebug(...) 
#define ECDebugIf(...)
#define ECDefineDebugChannel(...)
#define ECDebugChannelEnabled(channel) (false)

#endif
