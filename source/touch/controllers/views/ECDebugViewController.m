//
//  ECDebugViewController.m
//  ECFoundation
//
//  Created by Sam Deane on 28/08/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//

#import "ECBooleanEditableCell.h"
#import "ECDataItem.h"
#import "ECDebugViewController.h"
#import "ECLogChannel.h"
#import "ECLogManager.h"
#import "ECTickListTableController.h"

@interface ECDebugViewController()
- (void) channelSelected: (NSNotification*) notification;
@end

@implementation ECDebugViewController

ECDefineDebugChannel(DebugViewChannel);

static NSString *const kChannelKey = @"Channel";

- (void) viewDidLoad
{
	ECDataItem* data = [ECDataItem item];
	
	ECDataItem* channelsList = [ECDataItem item];
	for (ECLogChannel* channel in [ECLogManager sharedInstance].channels)
	{
		ECDataItem* item = [ECDataItem itemWithObjectsAndKeys: channel.name, kValueKey, [NSNumber numberWithBool: channel.enabled], @"enabled", channel, kChannelKey, nil];
		[channelsList addItem: item];
	}
	[channelsList setDefault: [ECBooleanEditableCell class] forKey: kCellClassKey];
	[channelsList setDefault: [NSDictionary dictionaryWithObject: @"enabled" forKey: kValueKey] forKey: kCellPropertiesKey];
	
	ECDataItem* channelsSection = [ECDataItem item];
	[channelsSection setObject: @"Channels" forKey: kValueKey];
	[channelsSection setBooleanDefault: YES forKey: kSelectableKey];
	[channelsSection addItem: channelsList];
	
	ECDataItem* loggingSection = [ECDataItem itemWithObjectsAndKeys: @"Logging", kHeaderKey, [ECLabelValueTableController class], kViewerKey, nil];
	[loggingSection addItem: channelsSection];

	[data addItem: loggingSection];
	
	self.data = data;
	self.title = @"Debug";
	
	[[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(channelSelected:) name: DataItemChildChanged object: channelsList];
}

- (void) channelSelected: (NSNotification*) notification
{
	ECDebug(DebugViewChannel, @"channel selected");
	
}

@end
