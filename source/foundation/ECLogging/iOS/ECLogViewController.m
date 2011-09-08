//
//  ECLogViewController.m
//  ECLoggingSample
//
//  Created by Sam Deane on 02/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ECLogViewController.h"
#import "ECLogViewHandler.h"
#import "ECLogViewHandlerItem.h"
#import "ECLogChannel.h"

@interface ECLogViewController()

@property (nonatomic, retain) UIFont* messageFont;
@property (nonatomic, retain) UIFont* contextFont;

@end

@implementation ECLogViewController

@synthesize messageFont;
@synthesize contextFont;

- (id)initWithStyle:(UITableViewStyle)style
{
    
    if ((self = [super initWithStyle:style]) != nil) 
    {
    }
    
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    [messageFont release];
    [contextFont release];
    
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    ECLogViewHandler* lh = [ECLogViewHandler sharedInstance];
    lh.view = self;

    [super viewDidLoad];

    self.messageFont = [UIFont systemFontOfSize:14];
    self.contextFont = [UIFont systemFontOfSize:10];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    ECLogViewHandler* lh = [ECLogViewHandler sharedInstance];
    lh.view = self;
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    ECLogViewHandler* lh = [ECLogViewHandler sharedInstance];
    lh.view = nil;

    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ECLogViewHandler* lh = [ECLogViewHandler sharedInstance];
    
    return [lh.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    ECLogViewHandler* lh = [ECLogViewHandler sharedInstance];
    ECLogViewHandlerItem* item = [lh.items objectAtIndex:indexPath.row];
    
    CGSize constraint = CGSizeMake(tableView.frame.size.width, 10000.0);
    CGSize messageSize = [item.message sizeWithFont:self.messageFont constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    CGSize contextSize = [item.channel.name sizeWithFont:self.contextFont constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];

    cell.textLabel.text = item.message;
    cell.textLabel.font = self.messageFont;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.frame = CGRectMake(0, 0, messageSize.width, messageSize.height);
    
    cell.detailTextLabel.text = item.channel.name;
    cell.detailTextLabel.font = self.contextFont;
    cell.textLabel.frame = CGRectMake(0, messageSize.height, contextSize.width, contextSize.height);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ECLogViewHandler* lh = [ECLogViewHandler sharedInstance];
    ECLogViewHandlerItem* item = [lh.items objectAtIndex:indexPath.row];

    CGSize constraint = CGSizeMake(tableView.frame.size.width, 10000.0);
    CGSize messageSize = [item.message sizeWithFont:self.messageFont constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    CGSize contextSize = [item.channel.name sizeWithFont:self.contextFont constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    return messageSize.height + contextSize.height;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
