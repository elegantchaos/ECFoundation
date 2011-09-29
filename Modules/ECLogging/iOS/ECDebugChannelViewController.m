// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECDebugChannelViewController.h"

#import "ECLogChannel.h"
#import "ECLogHandler.h"
#import "ECLogManager.h"
#import "ECLogContext.h"

// --------------------------------------------------------------------------
// Private Methods
// --------------------------------------------------------------------------

@interface ECDebugChannelViewController()
@end


@implementation ECDebugChannelViewController

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

@synthesize channel;
@synthesize handlers;

// --------------------------------------------------------------------------
// Constants
// --------------------------------------------------------------------------

enum
{
    kSettingsSection,
    kHandlersSection,
    kContextSection
};

typedef struct 
{
    ECLogContextFlags flag;
    NSString* name;
} ContextFlagInfo;

NSString *const kSections[] = { @"Settings", @"Handlers", @"Context" };

const ContextFlagInfo kContextFlagInfo[] = 
{
    { ECLogContextDefault, @"Use Defaults"},
    { ECLogContextFile, @"File" },
    { ECLogContextDate, @"Date"},
    { ECLogContextFunction, @"Function"}, 
    { ECLogContextMessage, @"Message"},
    { ECLogContextName, @"Name"}
};

- (id)initWithStyle:(UITableViewStyle)style
{
    if ((self = [super initWithStyle:style]) != nil)
    {
        self.handlers = [[ECLogManager sharedInstance] handlersSortedByName];
    }
    
    return self;
}

// --------------------------------------------------------------------------
//! Clean up.
// --------------------------------------------------------------------------

- (void)dealloc
{
    [channel release];
    [handlers release];
    
    [super dealloc];
}

#pragma mark UITableViewDataSource methods

// --------------------------------------------------------------------------
//! How many sections are there?
// --------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sizeof(kSections) / sizeof(NSString*);
}

// --------------------------------------------------------------------------
//! Return the header title for a section.
// --------------------------------------------------------------------------

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection: (NSInteger) section
{
    return kSections[section];
}

// --------------------------------------------------------------------------
//! Return the number of rows in a section.
// --------------------------------------------------------------------------

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger) section
{
    if (section == kSettingsSection)
    {
        return 1;
    }
    else if (section == kHandlersSection)
    {
        return [self.handlers count];
    }
    else
    {
        return sizeof(kContextFlagInfo) / sizeof(ContextFlagInfo);
    }
}


// --------------------------------------------------------------------------
//! Return the view for a given row.
// --------------------------------------------------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)path
{
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"ChannelViewCell"];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChannelViewCell"];
        [cell autorelease];
	}

	NSString* label;
    BOOL ticked;
    
    if (path.section == kSettingsSection)
    {
        label = @"Enabled";
        ticked = self.channel.enabled; 
    }
    else if (path.section == kHandlersSection)
    {
        ECLogHandler* handler = [self.handlers objectAtIndex: path.row];
        label = handler.name;
        ticked = [self.channel isHandlerEnabled:handler];
    }
    else
    {
        const ContextFlagInfo* info = &kContextFlagInfo[path.row];
        label = info->name;
        if (channel.context == ECLogContextDefault)
        {
            ticked = info->flag == ECLogContextDefault;
        }
        else
        {
            ticked = [self.channel showContext:info->flag];
        }
    }
    
    cell.textLabel.text = label;
	cell.accessoryType = ticked ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
	return cell;
}


// --------------------------------------------------------------------------
//! Handle selecting a table row.
// --------------------------------------------------------------------------

- (void) tableView:(UITableView*) table didSelectRowAtIndexPath:(NSIndexPath*) path
{
    if (path.section == kSettingsSection)
    {
        ECMakeContext();
        if (self.channel.enabled)
        {
            logToChannel(self.channel, &ecLogContext, @"disabled channel");
            self.channel.enabled = NO;
        }
        else
        {
            self.channel.enabled = YES;
            logToChannel(self.channel, &ecLogContext, @"enabled channel");
        }
    }
    else if (path.section == kHandlersSection)
    {
        ECLogHandler* handler = [self.handlers objectAtIndex: path.row];
        if ([self.channel isHandlerEnabled:handler]) 
        {
            [self.channel disableHandler:handler];
        }
        else
        {
            [self.channel enableHandler:handler];
        }
    }
    else
    {
        const ContextFlagInfo* info = &kContextFlagInfo[path.row];
        
        // if it's the default flag we're playing with, then we want to clear out all
        // other flags; if it's any other flag, we want to clear out the default flag
        if (info->flag == ECLogContextDefault)
        {
            self.channel.context &= ECLogContextDefault;
        }
        else
        {
            self.channel.context &= ~ECLogContextDefault;
        }

        // toggle the flag that was actually selected
        self.channel.context ^= info->flag;
    }

    [[ECLogManager sharedInstance] saveChannelSettings];
    
    [table deselectRowAtIndexPath: path animated: YES];
    [self.tableView reloadData];
}

@end
