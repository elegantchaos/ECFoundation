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

void enableChannel(ECLogChannel* channel)
{
	channel.enabled = YES;
}

BOOL channelEnabled(ECLogChannel* channel)
{
	return channel.enabled;
}

ECLogChannel* makeNewChannel(const char* name)
{
	ECLogChannel* channel = [[ECLogChannel alloc] initWithRawName: name];
	channel.enabled = NO;
	
	[[ECLogManager sharedInstance] registerChannel: channel];
	
	return channel;
}

extern void	logToChannel(ECLogChannel* channel, NSString* format, ...)
{
	va_list args;
	va_start(args, format);
	[[ECLogManager sharedInstance] logFromChannel: channel withFormat:format arguments:args];
	va_end(args);
}
