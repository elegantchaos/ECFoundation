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
@synthesize logManager;

// --------------------------------------------------------------------------
// Constants
// --------------------------------------------------------------------------

enum
{
    kSettingsSection,
    kHandlersSection,
    kContextSection,
    kResetSection
};

NSString *const kSections[] = { @"Settings", @"Handlers", @"Context", @"Reset" };

- (id)initWithStyle:(UITableViewStyle)style
{
    if ((self = [super initWithStyle:style]) != nil)
    {
        self.logManager = [ECLogManager sharedInstance];
    }
    
    return self;
}

// --------------------------------------------------------------------------
//! Clean up.
// --------------------------------------------------------------------------

- (void)dealloc
{
    [channel release];
    
    [super dealloc];
}

// --------------------------------------------------------------------------
//! Support any orientation.
// --------------------------------------------------------------------------

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
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
        return [self.logManager handlerCount];
    }
    else if (section == kContextSection)
    {
        return [self.logManager contextFlagCount];
    }
    else
    {
        return 1;
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
        label = [self.logManager handlerNameForIndex:path.row];
        ticked = [self.channel tickHandlerWithIndex:path.row];
    }
    else if (path.section == kContextSection)
    {
        label = [self.logManager contextFlagNameForIndex:path.row];
        ticked = [self.channel tickFlagWithIndex:path.row];
    }
    else
    {
        label = @"Reset";
        ticked = NO;
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
        [self.logManager saveChannelSettings];
    }
    else if (path.section == kHandlersSection)
    {
        [self.channel selectHandlerWithIndex:path.row];
    }
    else if (path.section == kContextSection)
    {
        [self.channel selectFlagWithIndex:path.row];
    }
    else
    {
        [self.logManager resetChannel:self.channel];
    }
    
    [table deselectRowAtIndexPath: path animated: YES];
    [self.tableView reloadData];
}

@end
