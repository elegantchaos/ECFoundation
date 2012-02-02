// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 02/02/2012
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECPopoverBarButtonItem.h"
#import "ECPopoverContentController.h"

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
        Class contentClass = NSClassFromString(self.content);
        UIViewController* contentController = [[contentClass alloc] initWithNibName:self.content bundle:nil];
        gShowingPopover = [[UIPopoverController alloc] initWithContentViewController:contentController];
        gShowingPopover.delegate = self;
        if ([contentController conformsToProtocol:@protocol(ECPopoverContentController)])
        {
            UIViewController<ECPopoverContentController>* coerced = (UIViewController<ECPopoverContentController>*) contentController;
            coerced.popover = gShowingPopover;
        }
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
