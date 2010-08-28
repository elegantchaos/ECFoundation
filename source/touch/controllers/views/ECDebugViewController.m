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
- (void) rebuildChannelsList;
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
	[channelsSection setObject: @"Channels" forKey: kValueKey];
	[channelsSection setBooleanDefault: YES forKey: kSelectableKey];
	[channelsSection addItem: channelsList];
	
	ECDataItem* loggingSection = [ECDataItem itemWithObjectsAndKeys: @"Logging", kHeaderKey, [ECLabelValueTableController class], kViewerKey, nil];
	[loggingSection addItem: channelsSection];

	[data addItem: loggingSection];
	
	self.data = data;
	self.title = @"Debug";
	self.channels = channelsList;
	[self rebuildChannelsList];
	
	NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
	[nc addObserver: self selector: @selector(channelSelected:) name: DataItemChildChanged object: channelsList];
	[nc addObserver: self selector: @selector(channelsChanged:) name: LogChannelsChanged object: nil];
}

// --------------------------------------------------------------------------
//! Respond to a channel being selected.
// --------------------------------------------------------------------------

- (void) channelSelected: (NSNotification*) notification
{
	ECDebug(DebugViewChannel, @"channel selected");
	
}

// --------------------------------------------------------------------------
//! Respond to a channel being selected.
// --------------------------------------------------------------------------

- (void) channelsChanged: (NSNotification*) notification
{
	ECDebug(DebugViewChannel, @"channels changed");
	[self rebuildChannelsList];
	[self.tableView reloadData];
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



@end
