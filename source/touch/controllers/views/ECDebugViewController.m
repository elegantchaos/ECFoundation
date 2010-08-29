// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 28/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECBooleanEditableCell.h"
#import "ECDataItem.h"
#import "ECDebugViewController.h"
#import "ECLogChannel.h"
#import "ECLogManager.h"
#import "ECTickListTableController.h"

// --------------------------------------------------------------------------
// Private Methods
// --------------------------------------------------------------------------

@interface ECDebugViewController()
- (void) channelSelected: (NSNotification*) notification;
- (void) channelsChanged: (NSNotification*) notification;
- (void) enableAllChannels: (NSNotification*) notification;
- (void) disableAllChannels: (NSNotification*) notification;
- (void) setChannel: (ECLogChannel*) channel enabled: (BOOL) enabled;
- (void) rebuildChannelsList;
- (void) updateChannelsFromList;
@end


@implementation ECDebugViewController

// --------------------------------------------------------------------------
// Log Channels
// --------------------------------------------------------------------------

ECDefineDebugChannel(DebugViewChannel);

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

ECPropertySynthesize(channels);

// --------------------------------------------------------------------------
// Constants
// --------------------------------------------------------------------------

static NSString *const kChannelKey = @"Channel";
static NSString *const kEnabledKey = @"Enabled";
static NSString *const kEnabledLabel = @"enabled";
static NSString *const kDisabledLabel = @"disabled";

static void* kChannelsContext;

// --------------------------------------------------------------------------
//! Finish setting up the view.
// --------------------------------------------------------------------------

- (void) viewDidLoad
{
	ECDebug(DebugViewChannel, @"setting up view");

	ECDataItem* data = [ECDataItem item];
	
	ECDataItem* channelsList = [ECDataItem item];
	[channelsList setDefault: [ECBooleanEditableCell class] forKey: kCellClassKey];
	[channelsList setDefault: [NSDictionary dictionaryWithObject: kEnabledKey forKey: kValueKey] forKey: kCellPropertiesKey];
	ECDataItem* channelsSection = [ECDataItem item];
	[channelsSection setObject: @"Enable Channels" forKey: kValueKey];
	[channelsSection setObject: [ECLabelValueTableController class] forKey: kViewerKey];
	[channelsSection setBooleanDefault: YES forKey: kSelectableKey];
	[channelsSection addItem: channelsList];
	
	ECDataItem* loggingSection = [ECDataItem itemWithObjectsAndKeys: @"Logging", kHeaderKey, nil];
	[loggingSection addItem: channelsSection];
	
	ECDataItem* enableAllItem = [ECDataItem itemWithObjectsAndKeys: @"Enable All", kValueKey, nil];
	[loggingSection addItem: enableAllItem];
	
	ECDataItem* disableAllItem = [ECDataItem itemWithObjectsAndKeys: @"Disable All", kValueKey, nil];
	[loggingSection addItem: disableAllItem];

	[data addItem: loggingSection];
	
	self.data = data;
	self.title = @"Debug";
	self.channels = channelsList;
	[self rebuildChannelsList];
	
	NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
	[nc addObserver: self selector: @selector(channelSelected:) name: DataItemChildChanged object: channelsList];
	[nc addObserver: self selector: @selector(enableAllChannels:) name: DataItemSelected object: enableAllItem];
	[nc addObserver: self selector: @selector(disableAllChannels:) name: DataItemSelected object: disableAllItem];
	[nc addObserver: self selector: @selector(channelsChanged:) name: LogChannelsChanged object: nil];
}

// --------------------------------------------------------------------------
//! Respond to a channel being selected.
// --------------------------------------------------------------------------

- (void) channelSelected: (NSNotification*) notification
{
	[self updateChannelsFromList];
}

// --------------------------------------------------------------------------
//! Respond to a channel being selected.
// --------------------------------------------------------------------------

- (void) channelsChanged: (NSNotification*) notification
{
	[self rebuildChannelsList];
	[self.tableView reloadData];
}

// --------------------------------------------------------------------------
//! Respond to a channel being selected.
// --------------------------------------------------------------------------

- (void) enableAllChannels: (NSNotification*) notification
{
	for (ECLogChannel* channel in [ECLogManager sharedInstance].channels)
	{
		[self setChannel: channel enabled: YES];
	}
	[self rebuildChannelsList];
}

// --------------------------------------------------------------------------
//! Respond to a channel being selected.
// --------------------------------------------------------------------------

- (void) disableAllChannels: (NSNotification*) notification
{
	for (ECLogChannel* channel in [ECLogManager sharedInstance].channels)
	{
		[self setChannel: channel enabled: NO];
	}
	[self rebuildChannelsList];
}

// --------------------------------------------------------------------------
//! Rebuild the list of log channels.
// --------------------------------------------------------------------------

- (void) rebuildChannelsList
{
	ECDataItem* channelsList = self.channels;
	[channelsList.items removeAllObjects];
	for (ECLogChannel* channel in [ECLogManager sharedInstance].channels)
	{
		ECDataItem* item = [ECDataItem itemWithObjectsAndKeys: channel.name, kValueKey, [NSNumber numberWithBool: channel.enabled], kEnabledKey, channel, kChannelKey, nil];
		[channelsList addItem: item];
	}	
}

// --------------------------------------------------------------------------
//! Rebuild the list of log channels.
// --------------------------------------------------------------------------

- (void) updateChannelsFromList
{
	ECDataItem* channelsList = self.channels;
	for (ECDataItem* channelItem in channelsList.items)
	{
		ECLogChannel* channel = [channelItem objectForKey: kChannelKey];
		if (channel)
		{
			[self setChannel: channel enabled:[[channelItem objectForKey: kEnabledKey] boolValue]];
		}
	}	
}

// --------------------------------------------------------------------------
//! Change the enabled state of a channel
// --------------------------------------------------------------------------

- (void) setChannel: (ECLogChannel*) channel enabled: (BOOL) newEnabled
{
	BOOL oldEnabled = channel.enabled;
	if (oldEnabled != newEnabled)
	{
		if (oldEnabled)
		{
			logToChannel(channel, @"disabled channel");
		}
		channel.enabled = newEnabled;
		if (newEnabled)
		{
			logToChannel(channel, @"enabled channel");
		}
	}
	
}

@end
