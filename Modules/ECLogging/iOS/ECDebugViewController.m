// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECDebugViewController.h"
#import "ECDebugChannelsViewController.h"

#import "ECLogChannel.h"
#import "ECLogManager.h"

// --------------------------------------------------------------------------
// Private Methods
// --------------------------------------------------------------------------

@interface ECDebugViewController()
- (void) showChannels;
@end


@implementation ECDebugViewController

@synthesize navController;

// --------------------------------------------------------------------------
// Log Channels
// --------------------------------------------------------------------------

ECDefineDebugChannel(DebugViewChannel);

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
// Constants
// --------------------------------------------------------------------------


typedef enum 
{
    kShowChannelsCommand,
    kEnableAllChannelsCommand,
    kDisableAllChannelsCommand
} Command;

typedef struct 
{
    NSString *const                 name;
    UITableViewCellAccessoryType    accessory;
    Command                         command;
} Item;

Item kItems[] = 
{
    { @"Channels", UITableViewCellAccessoryDisclosureIndicator, kShowChannelsCommand },
    { @"Enable All", UITableViewCellAccessoryNone, kEnableAllChannelsCommand },
    { @"Disable All", UITableViewCellAccessoryNone, kDisableAllChannelsCommand }
};

// --------------------------------------------------------------------------

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithStyle:UITableViewStyleGrouped]) != nil)
    {
    }
    
    return self;
}

- (void)dealloc 
{
    [navController release];
    
    [super dealloc];
}

// --------------------------------------------------------------------------
//! Finish setting up the view.
// --------------------------------------------------------------------------

- (void) viewDidLoad
{
	ECDebug(DebugViewChannel, @"setting up view");
}

// --------------------------------------------------------------------------
//! Show the channels sub-view
// --------------------------------------------------------------------------

- (void) showChannels
{
    ECDebugChannelsViewController* controller = [[ECDebugChannelsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    controller.title = @"Log Channels";
    
    UINavigationController* nav = self.navController;
    if (!nav)
    {
        nav = self.navigationController;
    }
    
    [nav pushViewController:controller animated:TRUE];
    [controller release];
}

#pragma mark UITableViewDataSource methods

// --------------------------------------------------------------------------
//! How many sections are there?
// --------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// --------------------------------------------------------------------------
//! Return the header title for a section.
// --------------------------------------------------------------------------

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection: (NSInteger) section
{
    return @"Logging";
}

// --------------------------------------------------------------------------
//! Return the number of rows in a section.
// --------------------------------------------------------------------------

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger) sectionIndex
{
    return sizeof(kItems) / sizeof(Item);
}


// --------------------------------------------------------------------------
//! Return the view for a given row.
// --------------------------------------------------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"DebugViewCell"];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DebugViewCell"];
        [cell autorelease];
	}
	
    Item* item = &kItems[indexPath.row];
    cell.textLabel.text = item->name;
	cell.accessoryType = item->accessory;
    
	return cell;
}


// --------------------------------------------------------------------------
//! Handle selecting a table row.
// --------------------------------------------------------------------------

- (void) tableView:(UITableView*) table didSelectRowAtIndexPath:(NSIndexPath*) path
{
    Item* item = &kItems[path.row];
	switch (item->command) 
    {
        case kShowChannelsCommand:
            [self showChannels];
            break;
            
        case kEnableAllChannelsCommand:
            [[ECLogManager sharedInstance] enableAllChannels];
            break;
            
        case kDisableAllChannelsCommand:
            [[ECLogManager sharedInstance] disableAllChannels];
            break;
    }
    
    [table deselectRowAtIndexPath: path animated: YES];
}

@end
