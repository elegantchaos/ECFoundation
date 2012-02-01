//
//  ECPopoverBarButtonItem.m
//  AllenOvery
//
//  Created by Sam Deane on 01/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ECPopoverBarButtonItem.h"

static UIPopoverController* gShowingPopover;

@interface ECPopoverBarButtonItem()

@property (strong, nonatomic) NSString* content;

- (IBAction)togglePopover:(id)sender;

@end

@implementation ECPopoverBarButtonItem

@synthesize content;

- (id)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style content:(NSString*)contentIn
{
    if ((self = [super initWithTitle:title style:style target:self action:@selector(togglePopover:)]))
    {
        self.content = contentIn;
    }
    
    return self;
}

- (void)dealloc
{
    [content release];
    
    [super dealloc];
}

- (IBAction)togglePopover:(id)sender
{
    if (gShowingPopover)
    {
        [gShowingPopover dismissPopoverAnimated:YES];
        [gShowingPopover release];
        gShowingPopover = nil;
    }
    else
    {
        UIViewController* contentController = [[UIViewController alloc] initWithNibName:self.content bundle:nil];
        gShowingPopover = [[UIPopoverController alloc] initWithContentViewController:contentController];
        gShowingPopover.delegate = self;
        [gShowingPopover setPopoverContentSize:contentController.view.frame.size animated:NO];
        [gShowingPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        [contentController release];
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    if (popoverController == gShowingPopover)
    {
        [gShowingPopover release];
        gShowingPopover = nil;
    }
}

@end
