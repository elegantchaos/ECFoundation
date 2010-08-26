// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 22/07/2010
//
//! @file:
//! Logging utilities.
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECLogging.h"
#import "ECLogChannel.h"
#import "ECLogManager.h"

BOOL channelEnabled(ECLogChannel* channel)
{
	return channel.enabled;
}

ECLogChannel* makeNewChannel(const char* name)
{
	ECLogChannel* channel = [[ECLogChannel alloc] init];
	channel.name = [NSString stringWithUTF8String: name];
	channel.enabled = YES;
	
	[[ECLogManager sharedInstance] registerChannel: channel];
	
	return channel;
}

extern void	logToChannel(ECLogChannel* channel, NSString* format, ...)
{
	va_list args;
	va_start(args, format);
	[channel logWithFormat: format arguments: args]; 
	va_end(args);
}
