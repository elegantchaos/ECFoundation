// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECLogManager.h"
#import "ECLogChannel.h"
#import "ECLogHandlerNSLog.h"


@interface ECLogManager()

// Turn this setting on to output debug message on the log manager itself, using NSLog
#define LOG_MANAGER_DEBUGGING 0

#if LOG_MANAGER_DEBUGGING
#define LogManagerLog NSLog
#else
#define LogManagerLog(...)
#endif

// --------------------------------------------------------------------------
// Private Properties
// --------------------------------------------------------------------------

@property (nonatomic, retain) NSMutableDictionary* settings;

// --------------------------------------------------------------------------
// Private Methods
// --------------------------------------------------------------------------

- (void) loadChannelSettings;
- (void) saveChannelSettings;
- (void) postUpdateNotification;

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
NSString *const kEnabledSetting = @"Enabled";
NSString *const kHandlersSetting = @"Handlers";

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

@synthesize channels;
@synthesize handlers;
@synthesize settings;
@synthesize defaultHandler;

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
//! Post a notification to the default queue to say that the channel list has changed.
//! Make sure that it only gets processed on idle, so that we don't get stuck
//! in an infinite loop if the notification causes another notification to be posted
// --------------------------------------------------------------------------

- (void) postUpdateNotification
{
    NSNotification* notification = [NSNotification notificationWithName: LogChannelsChanged object: self];
    [[NSNotificationQueue defaultQueue] enqueueNotification:notification postingStyle:NSPostWhenIdle coalesceMask:NSNotificationCoalescingOnName forModes: nil];
    
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
            if (handlerNames)
            {
                for (NSString* handlerName in handlerNames)
                {
                    ECLogHandler* handler = [self.handlers objectForKey:handlerName];
                    if (handler)
                    {
                        LogManagerLog(@"added channel %@ handler %@", channel.name, handler.name);
                        [channel enableHandler:handler];
                    }
                }
            }
        }
        else
        {
            [channel.handlers addObject:self.defaultHandler];
        }
        
        channel.setup = YES;
    }
    
    [self postUpdateNotification];    
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
	ECLogHandler* handler = [[ECLogHandlerNSLog alloc] init];
	[self registerHandler: handler];
    self.defaultHandler = handler;
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
	[channels release];
	
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

    NSDictionary* loadedSettings = [[NSUserDefaults standardUserDefaults] dictionaryForKey: kLogChannelSettings];

    for (NSString* channel in [loadedSettings allKeys])
    {
        [self registerChannelWithName:channel];
    }
         
    self.settings = [[loadedSettings mutableCopy] autorelease];
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
        NSMutableDictionary* channelSettings = [[NSMutableDictionary alloc] initWithObjectsAndKeys: 
                                                [NSNumber numberWithBool: channel.enabled], kEnabledSetting, 
                                                nil];
        
        NSSet* channelHandlers = channel.handlers;
        if (channelHandlers)
        {
            NSMutableArray* handlerNames = [NSMutableArray arrayWithCapacity:[channel.handlers count]];
            for (ECLogHandler* handler in channelHandlers)
            {
                [handlerNames addObject:handler.name];
            }
            [channelSettings setObject:handlerNames forKey:kHandlersSetting];
        }
        
        LogManagerLog(@"settings for channel %@:%@", channel.name, channelSettings);

		[allSettings setObject: channelSettings forKey: channel.name];
		[channelSettings release];
	}
	
	[[NSUserDefaults standardUserDefaults] setObject: allSettings forKey: kLogChannelSettings];
	[allSettings release];

}

// --------------------------------------------------------------------------
//! Log to all valid handlers for a channel
// --------------------------------------------------------------------------

- (void) logFromChannel: (ECLogChannel*) channel withFormat: (NSString*) format arguments: (va_list) arguments context:(ECLogContext*)context
{
    // if no handlers specified, use them all
    NSArray* handlersToUse = [channel.handlers allObjects];
    if (!handlersToUse)
    {
        handlersToUse = [self.handlers allValues];
    }
    
	for (ECLogHandler* handler in handlersToUse)
	{
		va_list arg_copy;
		va_copy(arg_copy, arguments);
		[handler logFromChannel: channel withFormat:format arguments:arg_copy context:context];
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
        [channel enable];
	}
}

// --------------------------------------------------------------------------
//! Turn off every channel.
// --------------------------------------------------------------------------

- (void) disableAllChannels
{
	for (ECLogChannel* channel in [self.channels allValues])
	{
        [channel disable];
	}
}

// --------------------------------------------------------------------------
//! Return an array of channels sorted by name.
// --------------------------------------------------------------------------

- (NSArray*)channelsSortedByName
{
    NSArray* channelObjects = [self.channels allValues];
    NSArray* sorted = [channelObjects sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];
    
    return sorted;
}

// --------------------------------------------------------------------------
//! Return an array of handlers sorted by name.
// --------------------------------------------------------------------------

- (NSArray*)handlersSortedByName
{
    NSArray* handlerObjects = [self.handlers allValues];
    NSArray* sorted = [handlerObjects sortedArrayUsingSelector: @selector(caseInsensitiveCompare:)];
    
    return sorted;
}

@end
