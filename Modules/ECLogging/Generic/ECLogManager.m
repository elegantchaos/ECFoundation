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

#import "NSDictionary+ECCore.h"

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
@property (nonatomic, retain) NSArray* handlersSorted;

// --------------------------------------------------------------------------
// Private Methods
// --------------------------------------------------------------------------

- (void)loadChannelSettings;
- (void)saveChannelSettings;
- (void)postUpdateNotification;

@end


@implementation ECLogManager

// --------------------------------------------------------------------------
// Notifications
// --------------------------------------------------------------------------

NSString *const LogChannelsChanged = @"LogChannelsChanged";

// --------------------------------------------------------------------------
// Constants
// --------------------------------------------------------------------------

NSString *const ContextSetting = @"Context";
NSString *const EnabledSetting = @"Enabled";
NSString *const HandlersSetting = @"Handlers";
NSString *const LevelSetting = @"Level";
NSString *const LogManagerSettings = @"LogManager";
NSString *const ChannelsSetting = @"Channels";
NSString *const DefaultsSetting = @"Defaults";

typedef struct 
{
    ECLogContextFlags flag;
    NSString* name;
} ContextFlagInfo;

const ContextFlagInfo kContextFlagInfo[] = 
{
    { ECLogContextDefault, @"Use Default Flags"},
    { ECLogContextFile, @"File" },
    { ECLogContextDate, @"Date"},
    { ECLogContextFunction, @"Function"}, 
    { ECLogContextMessage, @"Message"},
    { ECLogContextName, @"Name"}
};

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

@synthesize channels;
@synthesize defaultContextFlags;
@synthesize handlers;
@synthesize handlersSorted;
@synthesize settings;
@synthesize defaultHandlers;

// --------------------------------------------------------------------------
// Globals
// --------------------------------------------------------------------------

static ECLogManager* gSharedInstance = nil;

// --------------------------------------------------------------------------
//! Initialise the class.
// --------------------------------------------------------------------------

+ (void)initialize
{
    LogManagerLog(@"created log manager");
	gSharedInstance = [[ECLogManager alloc] init];
}

// --------------------------------------------------------------------------
//! Return the shared instance.
// --------------------------------------------------------------------------

+ (ECLogManager*)sharedInstance
{
	return gSharedInstance;
}

// --------------------------------------------------------------------------
//! Return the channel with a given name, making it first if necessary.
//! If the channel was created, we register it.
// --------------------------------------------------------------------------

- (ECLogChannel*)registerChannelWithRawName:(const char*)rawName options:(NSDictionary*)options;
{
    LogManagerLog(@"registering raw channel with name %s", rawName);
    NSString* name = [ECLogChannel cleanName:rawName];
    return [self registerChannelWithName:name options:options];
}

// --------------------------------------------------------------------------
//! Return the channel with a given name, making it first if necessary.
//! If the channel was created, we register it.
// --------------------------------------------------------------------------

- (ECLogChannel*)registerChannelWithName:(NSString*)name options:(NSDictionary*)options
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

- (void)postUpdateNotification
{
    NSNotification* notification = [NSNotification notificationWithName: LogChannelsChanged object: self];
    [[NSNotificationQueue defaultQueue] enqueueNotification:notification postingStyle:NSPostWhenIdle coalesceMask:NSNotificationCoalescingOnName forModes: nil];
    
}

// --------------------------------------------------------------------------
//! Apply some settings to a channel.
// --------------------------------------------------------------------------

- (void)applySettings:(NSDictionary*)channelSettings toChannel:(ECLogChannel*)channel
{
    channel.enabled = [[channelSettings objectForKey: EnabledSetting] boolValue];
    channel.level = [channelSettings objectForKey:LevelSetting];
    NSNumber* contextValue = [channelSettings objectForKey: ContextSetting];
    channel.context = contextValue ? ((ECLogContextFlags) [contextValue integerValue]) : ECLogContextDefault;
    LogManagerLog(@"loaded channel %@ setting enabled: %d", channel.name, channel.enabled);
    
    NSArray* handlerNames = [channelSettings objectForKey: HandlersSetting];
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
    else
    {
        channel.handlers = nil;
    }
}

// --------------------------------------------------------------------------
//! Register a channel with the log manager.
// --------------------------------------------------------------------------

- (void)registerChannel:(ECLogChannel*)channel
{
    LogManagerLog(@"adding channel %@", channel.name);
	[self.channels setObject: channel forKey: channel.name];
	
    if (self.settings)
    {
        NSDictionary* allChannels = [self.settings objectForKey:ChannelsSetting];
        NSDictionary* channelSettings = [allChannels objectForKey: channel.name];
        [self applySettings:channelSettings toChannel:channel];
        
        channel.setup = YES;
    }
    
    [self postUpdateNotification];    
}

// --------------------------------------------------------------------------
//! Regist a channel with the log manager.
// --------------------------------------------------------------------------

- (void)registerHandler:(ECLogHandler*)handler
{
	[self.handlers setObject:handler forKey:handler.name];
    self.handlersSorted = [[self.handlers allValues] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];

    // if this handler is in the list of defaults, add it to the defaults array
    // (if the list is empty and this is the first handler we've registered, we make it the default automatically)
	NSDictionary* allHandlersSettings = [self.settings objectForKey:HandlersSetting];
    NSArray* defaultHandlerSettings = [allHandlersSettings objectForKey:DefaultsSetting];
    if (([defaultHandlerSettings containsObject:handler.name]) || ((defaultHandlerSettings == nil) && ([self.defaultHandlers count] == 0)))
    {
        [self.defaultHandlers addObject:handler];
    }
    
    LogManagerLog(@"registered handler %@", handler.name);
}

// --------------------------------------------------------------------------
//! Regist the default log handler which just does an NSLog for each item.
// --------------------------------------------------------------------------

- (void) registerDefaultHandler
{
	ECLogHandler* handler = [[ECLogHandlerNSLog alloc] init];
	[self registerHandler: handler];
    [self.defaultHandlers addObject:handler];
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
        NSMutableArray* array = [[NSMutableArray alloc] init];
        self.defaultHandlers = array;
        [array release];
        self.defaultContextFlags = ECLogContextName | ECLogContextMessage;
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

    NSDictionary* loadedSettings = [[NSUserDefaults standardUserDefaults] dictionaryForKey:LogManagerSettings];
    if (!loadedSettings)
    {
        NSURL* defaultSettingsFile = [[NSBundle mainBundle] URLForResource:@"ECLogging" withExtension:@"plist"];
        loadedSettings = [NSDictionary dictionaryWithContentsOfURL:defaultSettingsFile];
    }
    
    NSDictionary* channelSettings = [loadedSettings objectForKey:ChannelsSetting];
    for (NSString* channel in [channelSettings allKeys])
    {
        [self registerChannelWithName:channel options:nil];
    }

    if (loadedSettings)
    {
        self.settings = [NSMutableDictionary dictionaryWithDictionary:loadedSettings];
    }
}

// --------------------------------------------------------------------------
//! Save out the channel settings for next time.
// --------------------------------------------------------------------------

- (void) saveChannelSettings
{
    LogManagerLog(@"log manager saving settings");
    
	NSMutableDictionary* allChannelSettings = [[NSMutableDictionary alloc] init];

	for (ECLogChannel* channel in [self.channels allValues])
	{
        NSMutableDictionary* channelSettings = [[NSMutableDictionary alloc] initWithObjectsAndKeys: 
                                                [NSNumber numberWithBool: channel.enabled], EnabledSetting,
                                                [NSNumber numberWithInteger: channel.context], ContextSetting,
                                                nil];
        
        NSSet* channelHandlers = channel.handlers;
        if (channelHandlers)
        {
            NSMutableArray* handlerNames = [NSMutableArray arrayWithCapacity:[channel.handlers count]];
            for (ECLogHandler* handler in channelHandlers)
            {
                [handlerNames addObject:handler.name];
            }
            [channelSettings setObject:handlerNames forKey:HandlersSetting];
        }
        
        LogManagerLog(@"settings for channel %@:%@", channel.name, channelSettings);

		[allChannelSettings setObject: channelSettings forKey: channel.name];
		[channelSettings release];
	}
	
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray* defaultHandlerNames = [NSMutableArray arrayWithCapacity:[self.defaultHandlers count]];
    for (ECLogHandler* handler in self.defaultHandlers)
    {
        [defaultHandlerNames addObject:handler.name];
    }

    NSDictionary* allHandlerSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                        defaultHandlerNames, DefaultsSetting,
                                        nil];
    
    NSDictionary* allSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                 allChannelSettings, ChannelsSetting,
                                 allHandlerSettings, HandlersSetting,
                                 nil];
    [defaults setObject:allSettings forKey:LogManagerSettings];
    
	[allChannelSettings release];

}

// --------------------------------------------------------------------------
//! Log to all valid handlers for a channel
// --------------------------------------------------------------------------

- (void)logFromChannel:(ECLogChannel*)channel withObject:(id)object arguments:(va_list)arguments context:(ECLogContext*)context
{
    // if no handlers specified, use them all
    NSArray* handlersToUse = [channel.handlers allObjects];
    if (!handlersToUse)
    {
        handlersToUse = self.defaultHandlers;
    }
    
	for (ECLogHandler* handler in handlersToUse)
	{
		va_list arg_copy;
		va_copy(arg_copy, arguments);
		[handler logFromChannel:channel withObject:object arguments:arg_copy context:context];
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
//! Revert all channels to default settings.
// --------------------------------------------------------------------------

- (void) resetChannel:(ECLogChannel *)channel
{
    NSURL* defaultSettingsFile = [[NSBundle mainBundle] URLForResource:@"ECLogging" withExtension:@"plist"];
    NSDictionary* defaultSettings = [NSDictionary dictionaryWithContentsOfURL:defaultSettingsFile];
	NSDictionary* allChannelSettings = [defaultSettings objectForKey:ChannelsSetting];
    [self applySettings:[allChannelSettings objectForKey:channel.name] toChannel:channel];
}

// --------------------------------------------------------------------------
//! Revert all channels to default settings.
// --------------------------------------------------------------------------

- (void) resetAllChannels
{
    NSURL* defaultSettingsFile = [[NSBundle mainBundle] URLForResource:@"ECLogging" withExtension:@"plist"];
    NSDictionary* defaultSettings = [NSDictionary dictionaryWithContentsOfURL:defaultSettingsFile];
	NSDictionary* allChannelSettings = [defaultSettings objectForKey:ChannelsSetting];
	for (NSString* name in self.channels)
	{
        ECLogChannel* channel = [self.channels objectForKey:name];
        [self applySettings:[allChannelSettings objectForKey:name] toChannel:channel];
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
//! Return a text label for a context info flag.
// --------------------------------------------------------------------------

- (NSString*)contextFlagNameForIndex:(NSUInteger)index
{
    return kContextFlagInfo[index].name;
}

// --------------------------------------------------------------------------
//! Return a context info flag.
// --------------------------------------------------------------------------

- (ECLogContextFlags)contextFlagValueForIndex:(NSUInteger)index
{
    return kContextFlagInfo[index].flag;
}

// --------------------------------------------------------------------------
//! Return the number of named context info flags.
// --------------------------------------------------------------------------

- (NSUInteger)contextFlagCount
{
    return sizeof(kContextFlagInfo) / sizeof(ContextFlagInfo);
}

// --------------------------------------------------------------------------
//! Return the handler for a given index.
//! Index 0 represents the Default Handlers, and returns nil.
// --------------------------------------------------------------------------

- (ECLogHandler*)handlerForIndex:(NSUInteger)index
{
    ECLogHandler* result;
    if (index == 0)
    {
        result = nil;
    }
    else
    {
        result = [self.handlersSorted objectAtIndex:index - 1];
    }
    
    return result;
}


// --------------------------------------------------------------------------
//! Return the name of a given handler index.
//! Index 0 represents the Default Handlers, and returns "Use Defaults".
// --------------------------------------------------------------------------

- (NSString*)handlerNameForIndex:(NSUInteger)index
{
    NSString* result;
    if (index == 0)
    {
        result = @"Use Default Handlers";
    }
    else
    {
        ECLogHandler* handler = [self.handlersSorted objectAtIndex:index - 1];
        result = handler.name;
    }
    
    return result;
}


// --------------------------------------------------------------------------
//! Return the number of handler indexes.
//! This is the number of handlers, plus one (or the "Use Defaults" label).
// --------------------------------------------------------------------------

- (NSUInteger)handlerCount
{
    return [self.handlers count] + 1;
}

@end
