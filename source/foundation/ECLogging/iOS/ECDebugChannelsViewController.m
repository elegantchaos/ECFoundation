// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECDebugChannelsViewController.h"
#import "ECDebugChannelViewController.h"

#import "ECLogChannel.h"
#import "ECLogManager.h"

// --------------------------------------------------------------------------
// Private Methods
// --------------------------------------------------------------------------

@interface ECDebugChannelsViewController()
@end


@implementation ECDebugChannelsViewController

// --------------------------------------------------------------------------
// Log Channels
// --------------------------------------------------------------------------

ECDefineDebugChannel(DebugChannelsViewChannel);

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

@synthesize channels;

// --------------------------------------------------------------------------
//! Clean up.
// --------------------------------------------------------------------------

- (void)dealloc
{
    [channels release];
    
    [super dealloc];
}

// --------------------------------------------------------------------------
//! Finish setting up the view.
// --------------------------------------------------------------------------

- (void) viewDidLoad
{
	ECDebug(DebugChannelsViewChannel, @"setting up view");

    self.channels = [[ECLogManager sharedInstance] channelsSortedByName];
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
    return @"Log Channels";
}

// --------------------------------------------------------------------------
//! Return the number of rows in a section.
// --------------------------------------------------------------------------

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger) sectionIndex
{
    return [self.channels count];
}


// --------------------------------------------------------------------------
//! Return the view for a given row.
// --------------------------------------------------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ECLogChannel* channel = [self.channels objectAtIndex:indexPath.row];
    
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"DebugViewCell"];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DebugViewCell"];
        [cell autorelease];
	}
	
    cell.textLabel.text = channel.name;
    cell.detailTextLabel.text = channel.enabled ? @"enabled" : @"disabled";
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
	return cell;
}


// --------------------------------------------------------------------------
//! Handle selecting a table row.
// --------------------------------------------------------------------------

- (void) tableView:(UITableView*) table didSelectRowAtIndexPath:(NSIndexPath*) path
{
    ECLogChannel* channel = [self.channels objectAtIndex:path.row];
    channel.enabled = !channel.enabled;
    [self.tableView reloadData];
}



// --------------------------------------------------------------------------
//! Handle a tap on the accessory button.
// --------------------------------------------------------------------------

- (void) tableView: (UITableView*) table accessoryButtonTappedForRowWithIndexPath: (NSIndexPath*) path
{
    ECLogChannel* channel = [self.channels objectAtIndex:path.row];
    ECDebugChannelViewController* controller = [[ECDebugChannelViewController alloc] initWithStyle:UITableViewStyleGrouped];
    controller.title = channel.name;
    controller.channel = channel;
    [self.navigationController pushViewController:controller animated:TRUE];
    [controller release];
}

@end
