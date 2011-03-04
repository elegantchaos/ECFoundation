// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 26/08/2010
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
	ECPropertyVariable(channels, NSMutableArray*);
	ECPropertyVariable(handlers, NSMutableArray*);
}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

ECPropertyRetained(channels, NSMutableArray*);
ECPropertyRetained(handlers, NSMutableArray*);

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

+ (ECLogManager*) sharedInstance;

- (void) registerChannel: (ECLogChannel*) channel;
- (void) registerHandler: (ECLogHandler*) handler;
- (void) registerDefaultHandler;
- (void) shutdown;
- (void) logFromChannel: (ECLogChannel*) channel withFormat: (NSString*) format arguments: (va_list) arguments;
- (void) enableAllChannels;
- (void) disableAllChannels;
- (void) saveChannelSettings;

@end

// --------------------------------------------------------------------------
// Notifications
// --------------------------------------------------------------------------

extern NSString *const LogChannelsChanged;
