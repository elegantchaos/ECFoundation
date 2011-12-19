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

#import "ECLogging.h"
#import "ECLogChannel.h"
#import "ECLogManager.h"

void makeContext(ECLogContext* context, const char* file, unsigned int line, const char* date, const char* function)
{
    context->file = file;
    context->line = line;
    context->date = date;
    context->function = function;
}

// --------------------------------------------------------------------------
//! C style routine to enable a channel.
// --------------------------------------------------------------------------

void enableChannel(ECLogChannel* channel)
{
    [channel enable];
}

// --------------------------------------------------------------------------
//! C style routine to disable a channel.
// --------------------------------------------------------------------------

void  disableChannel(ECLogChannel* channel)
{
    [channel disable];
}

// --------------------------------------------------------------------------
//! C style routine reporting whether a channel is enabled.
// --------------------------------------------------------------------------

bool channelEnabled(ECLogChannel* channel)
{
	return channel.enabled != NO;
}

// --------------------------------------------------------------------------
//! Create a new channel and register it. If a channel with the same name has
//! already been registered, it is simply returned.
// --------------------------------------------------------------------------

ECLogChannel* registerChannel(const char* name)
{
	ECLogChannel* channel = [[ECLogManager sharedInstance] registerChannelWithRawName: name options:nil];
	
	return channel;
}
// --------------------------------------------------------------------------
//! Create a new channel and register it. If a channel with the same name has
//! already been registered, it is simply returned.
// --------------------------------------------------------------------------

ECLogChannel* registerChannelWithOptions(const char* name, id options)
{
	ECLogChannel* channel = [[ECLogManager sharedInstance] registerChannelWithRawName:name options:options];
	
	return channel;
}

// --------------------------------------------------------------------------
//! C style routine to log to a channel.
// --------------------------------------------------------------------------

extern void	logToChannel(ECLogChannel* channel, ECLogContext* context, id object, ...)
{
	va_list args;
	va_start(args, object);
    [[ECLogManager sharedInstance] logFromChannel:channel withObject:object arguments:args context:context];
	va_end(args);
}
