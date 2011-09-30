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

@property (nonatomic, assign) ECLogManager* logManager;

@end


@implementation ECDebugChannelViewController

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

@synthesize channel;
@synthesize handlers;
@synthesize logManager;

// --------------------------------------------------------------------------
// Constants
// --------------------------------------------------------------------------

enum
{
    kSettingsSection,
    kHandlersSection,
    kContextSection
};

NSString *const kSections[] = { @"Settings", @"Handlers", @"Context" };

- (id)initWithStyle:(UITableViewStyle)style
{
    if ((self = [super initWithStyle:style]) != nil)
    {
        self.logManager = [ECLogManager sharedInstance];
        self.handlers = [self.logManager handlersSortedByName];
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
        return [self.handlers count] + 1;
    }
    else
    {
        return [self.logManager contextFlagCount];
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
        if (path.row == 0)
        {
            label = @"Use Defaults";
            ticked = self.channel.handlers == nil;
        }
        else
        {
            ECLogHandler* handler = [self.handlers objectAtIndex:path.row - 1];
            label = handler.name;
            ticked = self.channel.handlers && [self.channel isHandlerEnabled:handler];
        }
    }
    else
    {
        label = [self.logManager contextFlagNameForIndex:path.row];
        ticked = [self.channel tickFlagWithIndex:path.row];
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
        if (path.row == 0)
        {
            self.channel.handlers = nil;
        }
        else
        {
            ECLogHandler* handler = [self.handlers objectAtIndex:path.row - 1];
            if (self.channel.handlers && [self.channel isHandlerEnabled:handler]) 
            {
                [self.channel disableHandler:handler];
            }
            else
            {
                [self.channel enableHandler:handler];
            }
        }
    }
    else
    {
        [self.channel selectFlagWithIndex:path.row];
    }

    [self.logManager saveChannelSettings];
    
    [table deselectRowAtIndexPath: path animated: YES];
    [self.tableView reloadData];
}

@end
