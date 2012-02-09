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
#import "ECPopoverController.h"

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
    ECPopoverController* pc = [ECPopoverController sharedInstance];
    if ([pc isShowingPopover])
    {
        [pc dismissPopover];
    }
    else
    {
        [pc presentPopoverWithContentClass:self.content content:nil fromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}

@end
