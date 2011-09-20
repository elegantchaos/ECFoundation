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
    kHandlersSection
};

NSString *const kSections[] = { @"Settings", @"Handlers" };

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
    else
    {
        return [self.handlers count];
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
    else
    {
        ECLogHandler* handler = [self.handlers objectAtIndex: path.row];
        label = handler.name;
        ticked = [self.channel isHandlerEnabled:handler];
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
    else
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

    [[ECLogManager sharedInstance] saveChannelSettings];
    
    [table deselectRowAtIndexPath: path animated: YES];
    [self.tableView reloadData];
}

@end
