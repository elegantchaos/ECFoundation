// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 26/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECLogManager.h"
#import "ECLogChannel.h"

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
	[[NSNotificationCenter defaultCenter] postNotificationName: LogChannelsChanged object: self];
	
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
@end
