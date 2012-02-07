// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 02/02/2012
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECPopoverController.h"
#import "ECPopoverContentController.h"


@interface ECPopoverController()

@property (strong, nonatomic) UIPopoverController* showing;

- (UIPopoverController*)popoverWithContentClass:(NSString*)class;

@end

@implementation ECPopoverController

@synthesize showing;

EC_SYNTHESIZE_SINGLETON(ECPopoverController);

- (void)dealloc
{
    [showing release];
    
    [super dealloc];
}

- (void)dismissPopover
{
    if (self.showing)
    {
        [self.showing dismissPopoverAnimated:YES];
        self.showing = nil;
    }
}

- (UIPopoverController*)popoverWithContentClass:(NSString*)class
{
    UIPopoverController* result = nil;
    Class contentClass = NSClassFromString(class);
    
    UIViewController* contentController;
    NSURL* nibURL = [[NSBundle mainBundle] URLForResource:class withExtension:@"nib"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:[nibURL path]])
    {
        contentController = [[contentClass alloc] initWithNibName:class bundle:nil];
    }
    else 
    {
        contentController = [[contentClass alloc] init];
    }
    
    result = [[UIPopoverController alloc] initWithContentViewController:contentController];
    result.delegate = self;
    
    if ([contentController conformsToProtocol:@protocol(ECPopoverContentController)])
    {
        UIViewController<ECPopoverContentController>* coerced = (UIViewController<ECPopoverContentController>*) contentController;
        coerced.popover = result;
    }
    [result setPopoverContentSize:contentController.view.frame.size animated:NO];
    [contentController release];

    return [result autorelease];
}

- (void)presentPopoverWithContentClass:(NSString*)name fromRect:(CGRect)rect inView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated
{
    UIPopoverController* popover = [self popoverWithContentClass:name];

    [self dismissPopover];

    [popover presentPopoverFromRect:rect inView:view permittedArrowDirections:arrowDirections animated:animated];
    self.showing = popover;
}

- (void)presentPopoverWithContentClass:(NSString*)name fromBarButtonItem:(UIBarButtonItem *)item permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated
{
    UIPopoverController* popover = [self popoverWithContentClass:name];
    
    [self dismissPopover];
    
    [popover presentPopoverFromBarButtonItem:item permittedArrowDirections:arrowDirections animated:animated];
    self.showing = popover;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    if (popoverController == self.showing)
    {
        self.showing = nil;
    }
}

@end
