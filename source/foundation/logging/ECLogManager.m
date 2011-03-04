// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 26/08/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECLogManager.h"
#import "ECLogChannel.h"
#import "ECDefaultLogHandler.h"

// --------------------------------------------------------------------------
// Private Methods
// --------------------------------------------------------------------------

@interface ECLogManager()
- (void) saveChannelSettings;
@end


@implementation ECLogManager

// --------------------------------------------------------------------------
// Notifications
// --------------------------------------------------------------------------

NSString *const LogChannelsChanged = @"LogChannelsChanged";

// --------------------------------------------------------------------------
// Constants
// --------------------------------------------------------------------------

NSString *const kLogChannelSettings = @"LogChannels";

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

ECPropertySynthesize(channels);
ECPropertySynthesize(handlers);

// --------------------------------------------------------------------------
// Globals
// --------------------------------------------------------------------------

static ECLogManager* gSharedInstance = nil;

// --------------------------------------------------------------------------
//! Initialise the class.
// --------------------------------------------------------------------------

+ (void) initialize
{
	gSharedInstance = [[ECLogManager alloc] init];
}

// --------------------------------------------------------------------------
//! Return the shared instance.
// --------------------------------------------------------------------------

+ (ECLogManager*) sharedInstance
{
	return gSharedInstance;
}

// --------------------------------------------------------------------------
//! Regist a channel with the log manager.
// --------------------------------------------------------------------------

- (void) registerChannel: (ECLogChannel*) channel
{
	[self.channels addObject: channel];
	[self.channels sortUsingSelector: @selector(caseInsensitiveCompare:)];
	
	NSDictionary* allSettings = [[NSUserDefaults standardUserDefaults] dictionaryForKey: kLogChannelSettings];
	NSDictionary* channelSettings = [allSettings objectForKey: channel.name];
	if (channelSettings)
	{
		NSNumber* number = [channelSettings objectForKey: @"enabled"];
		if (number)
		{
			channel.enabled = [number boolValue];
		}
	}

	// post a notification to the default queue - make sure that it only gets processed on idle, so that we don't get stuck
	// in an infinite loop if the notification causes another notification to be posted
	NSNotification* notification = [NSNotification notificationWithName: LogChannelsChanged object: self];
	[[NSNotificationQueue defaultQueue] enqueueNotification:notification postingStyle:NSPostWhenIdle coalesceMask:NSNotificationCoalescingOnName forModes: nil];
}

// --------------------------------------------------------------------------
//! Regist a channel with the log manager.
// --------------------------------------------------------------------------

- (void) registerHandler: (ECLogHandler*) handler
{
	[self.handlers addObject: handler];
}

// --------------------------------------------------------------------------
//! Regist the default log handler which just does an NSLog for each item.
// --------------------------------------------------------------------------

- (void) registerDefaultHandler
{
	ECLogHandler* handler = [[ECDefaultLogHandler alloc] init];
	[self registerHandler: handler];
	[handler release];
}

// --------------------------------------------------------------------------
//! Initialise the log manager.
// --------------------------------------------------------------------------

- (id) init
{
	if ((self = [super init]) != nil)
	{
		NSMutableArray* array = [[NSMutableArray alloc] init];
		self.channels = array;
		[array release];
		array = [[NSMutableArray alloc] init];
		self.handlers = array;
		[array release];
		
	}
	
	return self;
}

// --------------------------------------------------------------------------
//! Cleanup and release retained objects.
// --------------------------------------------------------------------------

- (void) dealloc
{
	ECPropertyDealloc(channels);
	
	[super dealloc];
}

// --------------------------------------------------------------------------
//! Cleanup and shut down.
// --------------------------------------------------------------------------

- (void) shutdown
{
	[self saveChannelSettings];
	self.channels = nil;
}

// --------------------------------------------------------------------------
//! Save out the channel settings for next time.
// --------------------------------------------------------------------------

- (void) saveChannelSettings
{
	NSMutableDictionary* allSettings = [[NSMutableDictionary alloc] init];
	for (ECLogChannel* channel in self.channels)
	{
		NSDictionary* channelSettings = [[NSDictionary alloc] initWithObjectsAndKeys: [NSNumber numberWithBool: channel.enabled], @"enabled", nil];
		[allSettings setObject: channelSettings forKey: channel.name];
		[channelSettings release];
	}
	
	[[NSUserDefaults standardUserDefaults] setObject: allSettings forKey: kLogChannelSettings];
	[allSettings release];

}

// --------------------------------------------------------------------------
//! Log to all handlers
// --------------------------------------------------------------------------

- (void) logFromChannel: (ECLogChannel*) channel withFormat: (NSString*) format arguments: (va_list) arguments
{
	for (ECLogHandler* handler in self.handlers)
	{
		[handler logFromChannel: channel withFormat: format arguments: arguments];
	}
}

// --------------------------------------------------------------------------
//! Turn on every channel.
// --------------------------------------------------------------------------

- (void) enableAllChannels
{
	for (ECLogChannel* channel in self.channels)
	{
		channel.enabled = YES;
	}
}

// --------------------------------------------------------------------------
//! Turn off every channel.
// --------------------------------------------------------------------------

- (void) disableAllChannels
{
	for (ECLogChannel* channel in self.channels)
	{
		channel.enabled = NO;
	}
}

@end
