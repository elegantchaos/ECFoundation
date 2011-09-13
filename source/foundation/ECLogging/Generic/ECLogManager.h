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
@private
	NSMutableDictionary* channels;
	NSMutableDictionary* handlers;
	ECLogHandler* defaultHandler;
	NSMutableDictionary* settings;
}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

@property (nonatomic, retain) NSMutableDictionary* channels;
@property (nonatomic, retain) NSMutableDictionary* handlers;
@property (nonatomic, retain) ECLogHandler* defaultHandler;

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
- (void)            logFromChannel: (ECLogChannel*) channel withFormat: (NSString*) format arguments: (va_list) arguments context:(ECLogContext*)context;
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
