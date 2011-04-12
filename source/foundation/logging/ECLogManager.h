// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@class ECLogChannel;
@class ECLogHandler;

// --------------------------------------------------------------------------
//! Manager which keeps track of all the log channels.
// --------------------------------------------------------------------------

@interface ECLogManager : NSObject
{
	ECPropertyVariable(channels, NSMutableDictionary*);
	ECPropertyVariable(handlers, NSMutableDictionary*);
	ECPropertyVariable(settings, NSMutableDictionary*);
    ECPropertyVariable(defaultHandler, ECLogHandler*);
}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

ECPropertyRetained(channels, NSMutableDictionary*);
ECPropertyRetained(handlers, NSMutableDictionary*);
ECPropertyRetained(defaultHandler, ECLogHandler*);

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

+ (ECLogManager*)   sharedInstance;

- (ECLogChannel*)   registerChannelWithRawName: (const char*) rawName;
- (ECLogChannel*)   registerChannelWithName: (NSString*) name;
- (void)            registerChannel: (ECLogChannel*) channel;
- (void)            registerHandler: (ECLogHandler*) handler;
- (void)            registerDefaultHandler;
- (void)            startup;
- (void)            shutdown;
- (void)            logFromChannel: (ECLogChannel*) channel withFormat: (NSString*) format arguments: (va_list) arguments;
- (void)            enableAllChannels;
- (void)            disableAllChannels;
- (void)            saveChannelSettings;

- (NSArray*)        channelsSortedByName;
- (NSArray*)        handlersSortedByName;

@end

// --------------------------------------------------------------------------
// Notifications
// --------------------------------------------------------------------------

extern NSString *const LogChannelsChanged;
