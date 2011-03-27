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

#import "ECLogging.h"
#import "ECLogChannel.h"
#import "ECLogManager.h"

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

BOOL channelEnabled(ECLogChannel* channel)
{
	return channel.enabled;
}

// --------------------------------------------------------------------------
//! Create a new channel and register it. If a channel with the same name has
//! already been registered, it is simply returned.
// --------------------------------------------------------------------------

ECLogChannel* registerChannel(const char* name)
{
	ECLogChannel* channel = [[ECLogManager sharedInstance] registerChannelWithRawName: name];
	
	return channel;
}

// --------------------------------------------------------------------------
//! C style routine to log to a channel.
// --------------------------------------------------------------------------

extern void	logToChannel(ECLogChannel* channel, NSString* format, ...)
{
	va_list args;
	va_start(args, format);
	[[ECLogManager sharedInstance] logFromChannel: channel withFormat:format arguments:args];
	va_end(args);
}
