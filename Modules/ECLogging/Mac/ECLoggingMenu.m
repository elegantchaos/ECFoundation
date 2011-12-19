// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/11/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECLoggingMenu.h"
#import "NSMenu+ECCore.h"

#import "ECLogManager.h"
#import "ECLogChannel.h"
#import "ECLogHandler.h"

// --------------------------------------------------------------------------
// Private Methods
// --------------------------------------------------------------------------

@interface ECLoggingMenu()

- (void)setup;
- (void)buildMenu;
- (void)channelsChanged:(NSNotification*)notification;

@end


@implementation ECLoggingMenu


#pragma mark - Lifecycle

// --------------------------------------------------------------------------
//! Set up after creation from a nib.
// --------------------------------------------------------------------------

- (void)awakeFromNib
{
	[self setup];
}

// --------------------------------------------------------------------------
//! Setup after creation from code.
// --------------------------------------------------------------------------

- (id)initWithTitle:(NSString*)title
{
	if ((self = [super initWithTitle: title]) != nil)
	{
		[self setup];
	}
	
	return self;
}

// --------------------------------------------------------------------------
//! Clean up.
// --------------------------------------------------------------------------

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver: self];
	
	[super dealloc];
}


// --------------------------------------------------------------------------
//! Create the menu items.
// --------------------------------------------------------------------------

- (void)setup
{
#if EC_DEBUG
    mLogManager = [ECLogManager sharedInstance];
	NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
	[nc addObserver: self selector: @selector(channelsChanged:) name: LogChannelsChanged object: nil];
	[self buildMenu];
#else
	for (NSMenuItem* item in self.supermenu.itemArray)
	{
		if (item.submenu == self)
		{
			[self.supermenu removeItem: item];
			break;
		}
	}
#endif
}

// --------------------------------------------------------------------------
//! Build a channel submenu.
// --------------------------------------------------------------------------

- (NSMenu*)buildMenuForChannel:(ECLogChannel*)channel
{
    NSMenu* menu = [[NSMenu alloc] initWithTitle:channel.name];
    
    NSMenuItem* item = [[NSMenuItem alloc] initWithTitle: @"Enabled" action: @selector(channelSelected:) keyEquivalent: @""];
    item.target = self;
    item.state = channel.enabled ? NSOnState : NSOffState;
    item.representedObject = channel;
    [menu addItem: item];
    [item release];
    
    [menu addItem: [NSMenuItem separatorItem]];
	
    NSUInteger count = [mLogManager handlerCount];
    for (NSUInteger n = 0; n < count; ++n)
	{
        NSMenuItem* item = [[NSMenuItem alloc] initWithTitle: [mLogManager handlerNameForIndex:n] action: @selector(handlerSelected:) keyEquivalent: @""];
        item.target = self;
        item.tag = n;
        [menu addItem: item];
        [item release];
    }
    
    [menu addItem: [NSMenuItem separatorItem]];
    
    count = [mLogManager contextFlagCount];
    for (NSUInteger n = 0; n < count; ++n)
    {
        NSString* name = [mLogManager contextFlagNameForIndex:n];
		NSMenuItem* item = [[NSMenuItem alloc] initWithTitle:name action: @selector(contextMenuSelected:) keyEquivalent: @""];
		item.target = self;
        item.tag = n;
		[menu addItem: item];
		[item release];
    }
    
    [menu addItem: [NSMenuItem separatorItem]];
    item = [[NSMenuItem alloc] initWithTitle:@"Reset" action: @selector(resetSelected:) keyEquivalent: @""];
    item.target = self;
    item.representedObject = channel;
    [menu addItem: item];
    [item release];

    return [menu autorelease];
}

// --------------------------------------------------------------------------
//! Build a channel submenu.
// --------------------------------------------------------------------------

- (NSMenu*)buildDefaultHandlersMenu
{
    NSMenu* menu = [[NSMenu alloc] initWithTitle:@"Default Handlers"];
    
    NSUInteger count = [mLogManager handlerCount];
    for (NSUInteger n = 1; n < count; ++n)
	{
        ECLogHandler* handler = [mLogManager handlerForIndex:n];
        NSMenuItem* item = [[NSMenuItem alloc] initWithTitle: handler.name action: @selector(defaultHandlerSelected:) keyEquivalent: @""];
        item.target = self;
        item.representedObject = handler;
        [menu addItem:item];
        [item release];
        
    }

    return [menu autorelease];
}

// --------------------------------------------------------------------------
//! Build the channels menu.
//! We make some global items, then a submenu for each registered channel.
// --------------------------------------------------------------------------

- (void)buildMenu
{
#if EC_DEBUG
    [self removeAllItemsEC];
    
    NSMenuItem* enableAllItem = [[NSMenuItem alloc] initWithTitle: @"Enable All Channels" action: @selector(enableAllChannels) keyEquivalent: @""];
    enableAllItem.target = mLogManager;
    [self addItem: enableAllItem];
    [enableAllItem release];
    
    NSMenuItem* disableAllItem = [[NSMenuItem alloc] initWithTitle: @"Disable All Channels" action: @selector(disableAllChannels) keyEquivalent: @""];
    disableAllItem.target = mLogManager;
    [self addItem: disableAllItem];
    [disableAllItem release];

    NSMenuItem* resetAllItem = [[NSMenuItem alloc] initWithTitle: @"Reset All Channels" action: @selector(resetAllChannels) keyEquivalent: @""];
    resetAllItem.target = mLogManager;
    [self addItem: resetAllItem];
    [resetAllItem release];

    [self addItem:[NSMenuItem separatorItem]];

    NSMenuItem* item = [[NSMenuItem alloc] initWithTitle:@"Default Handlers" action:nil keyEquivalent: @""];
    item.submenu = [self buildDefaultHandlersMenu];
    item.target = self;
    [self addItem: item];
    [item release];
    
    [self addItem:[NSMenuItem separatorItem]];

	for (ECLogChannel* channel in mLogManager.channelsSortedByName)
	{
		NSMenuItem* item = [[NSMenuItem alloc] initWithTitle: channel.name action: @selector(channelMenuSelected:) keyEquivalent: @""];
        item.submenu = [self buildMenuForChannel:channel];
		item.target = self;
		item.representedObject = channel;
		[self addItem: item];
		[item release];
	}
#endif
}

#pragma mark - Actions

// --------------------------------------------------------------------------
//! Respond to a channel menu item being selected.
//! We enabled/disable the channel.
// --------------------------------------------------------------------------

- (IBAction)channelMenuSelected:(NSMenuItem*)item
{
	ECLogChannel* channel = item.representedObject;
	channel.enabled = !channel.enabled;
	[mLogManager saveChannelSettings];
}

// --------------------------------------------------------------------------
//! Respond to a channel menu item being selected.
//! We enabled/disable the channel.
// --------------------------------------------------------------------------

- (IBAction)contextMenuSelected:(NSMenuItem*)item
{
    ECLogChannel* channel = [item parentItem].representedObject;
    [channel selectFlagWithIndex:item.tag];
}

// --------------------------------------------------------------------------
//! Respond to a channel menu item being selected.
//! We enabled/disable the channel.
// --------------------------------------------------------------------------

- (IBAction)channelSelected:(NSMenuItem*)item
{
	ECLogChannel* channel = item.representedObject;
	channel.enabled = !channel.enabled;
	[mLogManager saveChannelSettings];
}

// --------------------------------------------------------------------------
//! Respond to a handler menu item being selected.
//! We enable/disable the handler for the channel that the parent menu represents.
// --------------------------------------------------------------------------

- (IBAction)handlerSelected:(NSMenuItem*)item
{
    ECLogChannel* channel = [item parentItem].representedObject;
    [channel selectHandlerWithIndex:item.tag];
}

// --------------------------------------------------------------------------
//! Respond to a handler menu item being selected.
//! We enable/disable the handler for the channel that the parent menu represents.
// --------------------------------------------------------------------------

- (IBAction)resetSelected:(NSMenuItem*)item
{
    ECLogChannel* channel = [item parentItem].representedObject;
    [mLogManager resetChannel:channel];
}

// --------------------------------------------------------------------------
//! Respond to a default handler menu item being selected.
//! We add/remove the handler from the default handlers array
// --------------------------------------------------------------------------

- (IBAction)defaultHandlerSelected:(NSMenuItem*)item
{
	ECLogHandler* handler = item.representedObject;
    
    BOOL currentlyEnabled = [mLogManager.defaultHandlers containsObject:handler];
    BOOL newEnabled = !currentlyEnabled;
    
    if (newEnabled)
    {
        [mLogManager.defaultHandlers addObject:handler];
    }
    else
	{
        [mLogManager.defaultHandlers removeObject:handler];
    }
    
	[mLogManager saveChannelSettings];
}

// --------------------------------------------------------------------------
//! Respond to change notification by rebuilding all items.
// --------------------------------------------------------------------------

- (void)channelsChanged:(NSNotification*)notification
{
	[self buildMenu];
}

// --------------------------------------------------------------------------
//! Update the state of the menu items to reflect the current state of the 
//! channels/handlers that they represent.
// --------------------------------------------------------------------------

- (BOOL)validateMenuItem:(NSMenuItem*)item
{
    if ((item.action == @selector(channelSelected:))|| (item.action == @selector(channelMenuSelected:)))
    {
        ECLogChannel* channel = item.representedObject;
        item.state = channel.enabled ? NSOnState : NSOffState;
    }
    
    else if (item.action == @selector(handlerSelected:))
    {
        ECLogChannel* channel = [item parentItem].representedObject;
        
        BOOL currentlyEnabled = [channel tickHandlerWithIndex:item.tag];
        item.state = currentlyEnabled ? NSOnState : NSOffState;
    }
    
    else if (item.action == @selector(contextMenuSelected:))
    {
        ECLogChannel* channel = [item parentItem].representedObject;

        BOOL currentlyEnabled = [channel tickFlagWithIndex:item.tag];
        item.state = currentlyEnabled ? NSOnState : NSOffState;
    }
    
    else if (item.action == @selector(defaultHandlerSelected:))
    {
        ECLogHandler* handler = item.representedObject;
        
        BOOL currentlyEnabled = [mLogManager.defaultHandlers containsObject:handler];
        item.state = currentlyEnabled ? NSOnState : NSOffState;
    }
    
    return YES;
}

@end
