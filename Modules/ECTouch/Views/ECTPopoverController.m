// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 02/02/2012
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTPopoverController.h"
#import "ECTPopoverContentController.h"


@interface ECTPopoverController()

@property (strong, nonatomic) UIPopoverController* showing;

- (UIPopoverController*)popoverWithContentClass:(NSString*)class content:(id)content;

@end

@implementation ECTPopoverController

@synthesize showing;

EC_SYNTHESIZE_SINGLETON(ECTPopoverController);

- (void)dealloc
{
    [showing release];
    
    [super dealloc];
}

- (BOOL)isShowingPopover
{
    return self.showing != nil;
}

- (void)dismissPopover
{
    if (self.showing)
    {
        [self.showing dismissPopoverAnimated:YES];
        self.showing = nil;
    }
}

- (UIPopoverController*)popoverWithContentClass:(NSString*)class content:(id)content
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
    
    if ([contentController conformsToProtocol:@protocol(ECTPopoverContentController)])
    {
        UIViewController<ECTPopoverContentController>* coerced = (UIViewController<ECTPopoverContentController>*) contentController;
        coerced.popover = result;
        if ([coerced respondsToSelector:@selector(setupWithContent:)])
        {
            [coerced setupWithContent:content];
        }
    }
    [result setPopoverContentSize:contentController.view.frame.size animated:NO];
    [contentController release];

    return [result autorelease];
}

- (void)presentPopoverWithContentClass:(NSString*)name content:(id)content fromRect:(CGRect)rect inView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated
{
UIPopoverController* popover = [self popoverWithContentClass:name content:content];

    [self dismissPopover];

    [popover presentPopoverFromRect:rect inView:view permittedArrowDirections:arrowDirections animated:animated];
    self.showing = popover;
}

- (void)presentPopoverWithContentClass:(NSString*)name content:(id)content fromBarButtonItem:(UIBarButtonItem *)item permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated
{
    UIPopoverController* popover = [self popoverWithContentClass:name content:content];
    
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
