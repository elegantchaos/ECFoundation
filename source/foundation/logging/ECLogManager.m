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


@interface ECLogManager()

#define LOG_MANAGER_DEBUGGING 1

#if LOG_MANAGER_DEBUGGING
#define LogManagerLog NSLog
#else
#define LogManagerLog(...)
#endif

// --------------------------------------------------------------------------
// Private Properties
// --------------------------------------------------------------------------

ECPropertyRetained(settings, NSMutableDictionary*);

// --------------------------------------------------------------------------
// Private Methods
// --------------------------------------------------------------------------

- (void) loadChannelSettings;
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

NSString *const kLogChannelSettings = @"Log Channels";
NSString *const kEnabledSetting = @"Enabled";
NSString *const kHandlersSetting = @"Handlers";

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

ECPropertySynthesize(channels);
ECPropertySynthesize(handlers);
ECPropertySynthesize(settings);

// --------------------------------------------------------------------------
// Globals
// --------------------------------------------------------------------------

static ECLogManager* gSharedInstance = nil;

// --------------------------------------------------------------------------
//! Initialise the class.
// --------------------------------------------------------------------------

+ (void) initialize
{
    LogManagerLog(@"created log manager");
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
//! Return the channel with a given name, making it first if necessary.
//! If the channel was created, we register it.
// --------------------------------------------------------------------------

- (ECLogChannel*) registerChannelWithRawName: (const char*) rawName;
{
    LogManagerLog(@"registering raw channel with name %s", rawName);
    NSString* name = [ECLogChannel cleanName:rawName];
    return [self registerChannelWithName:name];
}

// --------------------------------------------------------------------------
//! Return the channel with a given name, making it first if necessary.
//! If the channel was created, we register it.
// --------------------------------------------------------------------------

- (ECLogChannel*) registerChannelWithName: (NSString*) name;
{
    LogManagerLog(@"registering channel with name %@", name);
    ECLogChannel* channel = [self.channels objectForKey:name];
    if (!channel)
    {
        channel = [[[ECLogChannel alloc] initWithName: name] autorelease];
        channel.enabled = NO;
    }

    if (!channel.setup)
    {
        [self registerChannel:channel];
    }
    
    return channel;
}

// --------------------------------------------------------------------------
//! Register a channel with the log manager.
// --------------------------------------------------------------------------

- (void) registerChannel: (ECLogChannel*) channel
{
    LogManagerLog(@"adding channel %@", channel.name);
	[self.channels setObject: channel forKey: channel.name];
	
    if (self.settings)
    {
        NSDictionary* channelSettings = [self.settings objectForKey: channel.name];
        if (channelSettings)
        {
            channel.enabled = [[channelSettings objectForKey: kEnabledSetting] boolValue];
            LogManagerLog(@"loaded channel %@ setting enabled: %d", channel.name, channel.enabled);
            
            NSArray* handlerNames = [channelSettings objectForKey: kHandlersSetting];
            for (NSString* handlerName in handlerNames)
            {
                ECLogHandler* handler = [self.handlers objectForKey:handlerName];
                if (handler)
                {
                    LogManagerLog(@"added channel %@ handler %@", channel.name, handler.name);
                    [channel.handlers addObject: handler];
                }
            }
        }
        
        channel.setup = YES;
        
        // post a notification to the default queue - make sure that it only gets processed on idle, so that we don't get stuck
        // in an infinite loop if the notification causes another notification to be posted
        NSNotification* notification = [NSNotification notificationWithName: LogChannelsChanged object: self];
        [[NSNotificationQueue defaultQueue] enqueueNotification:notification postingStyle:NSPostWhenIdle coalesceMask:NSNotificationCoalescingOnName forModes: nil];
    }
}

// --------------------------------------------------------------------------
//! Regist a channel with the log manager.
// --------------------------------------------------------------------------

- (void) registerHandler: (ECLogHandler*) handler
{
	[self.handlers setObject: handler forKey:handler.name];
    LogManagerLog(@"registered handler %@", handler.name);
}

// --------------------------------------------------------------------------
//! Regist the default log handler which just does an NSLog for each item.
// --------------------------------------------------------------------------

- (void) registerDefaultHandler
{
	ECLogHandler* handler = [[ECDefaultLogHandler alloc] init];
    handler.name = @"Default";
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
        LogManagerLog(@"initialised log manager");
        
		NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
		self.channels = dictionary;
		[dictionary release];
		dictionary = [[NSMutableDictionary alloc] init];
		self.handlers = dictionary;
		[dictionary release];
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
//! Start the log manager.
//! This should be called after handlers have been registered.
// --------------------------------------------------------------------------

- (void) startup
{
    LogManagerLog(@"log manager startup");
    
    [self loadChannelSettings];
}

// --------------------------------------------------------------------------
//! Cleanup and shut down.
// --------------------------------------------------------------------------

- (void) shutdown
{
	[self saveChannelSettings];
	self.channels = nil;
    self.handlers = nil;
    self.settings = nil;

    LogManagerLog(@"log manager shutdown");
}

// --------------------------------------------------------------------------
//! Load saved channel details.
//! We make and register any channel found in the settings.
// --------------------------------------------------------------------------

- (void) loadChannelSettings
{
    LogManagerLog(@"log manager loading settings");

    NSDictionary* settings = [[NSUserDefaults standardUserDefaults] dictionaryForKey: kLogChannelSettings];

    for (NSString* channel in [settings allKeys])
    {
        [self registerChannelWithName:channel];
    }
         
    self.settings = [settings mutableCopy];
}

// --------------------------------------------------------------------------
//! Save out the channel settings for next time.
// --------------------------------------------------------------------------

- (void) saveChannelSettings
{
    LogManagerLog(@"log manager saving settings");
    
	NSMutableDictionary* allSettings = [[NSMutableDictionary alloc] init];
	for (ECLogChannel* channel in [self.channels allValues])
	{
        NSSet* handlers = channel.handlers;
        NSMutableArray* handlerNames = [NSMutableArray arrayWithCapacity:[channel.handlers count]];
        for (ECLogHandler* handler in handlers)
        {
            [handlerNames addObject:handler.name];
        }
        
		NSDictionary* channelSettings = [[NSDictionary alloc] initWithObjectsAndKeys: 
                                         [NSNumber numberWithBool: channel.enabled], kEnabledSetting, 
                                         handlerNames, kHandlersSetting,
                                         nil];
        
        LogManagerLog(@"settings for channel %@:%@", channel.name, channelSettings);

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
	for (ECLogHandler* handler in channel.handlers)
	{
		[handler logFromChannel: channel withFormat: format arguments: arguments];
	}
}

// --------------------------------------------------------------------------
//! Turn on every channel.
// --------------------------------------------------------------------------

- (void) enableAllChannels
{
    LogManagerLog(@"enabling all channels");
    
	for (ECLogChannel* channel in [self.channels allValues])
	{
		channel.enabled = YES;
        logToChannel(channel, @"enabled channel");
	}
}

// --------------------------------------------------------------------------
//! Turn off every channel.
// --------------------------------------------------------------------------

- (void) disableAllChannels
{
	for (ECLogChannel* channel in [self.channels allValues])
	{
        logToChannel(channel, @"disabled channel");
		channel.enabled = NO;
	}
}

// --------------------------------------------------------------------------
//! Return an array of channels sorted by name.
// --------------------------------------------------------------------------

- (NSArray*)channelsSortedByName
{
    NSArray* channels = [self.channels allValues];
    NSArray* sorted = [channels sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];
    
    return sorted;
}

// --------------------------------------------------------------------------
//! Return an array of handlers sorted by name.
// --------------------------------------------------------------------------

- (NSArray*)handlersSortedByName
{
    NSArray* handlers = [self.handlers allValues];
    NSArray* sorted = [handlers sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];
    
    return sorted;
}

@end
