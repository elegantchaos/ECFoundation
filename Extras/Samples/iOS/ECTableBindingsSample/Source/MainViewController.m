// --------------------------------------------------------------------------
//! @author Sam Deane
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "MainViewController.h"

#import "AppDelegate.h"
#import "ModelController.h"
#import "ModelObject.h"

#import "ECPopoverBarButtonItem.h"
#import "ECTSection.h"
#import "ECTSectionDrivenTableController.h"

#import "NSArray+ECCore.h"

@interface MainViewController()

- (void)updateUI;

@end

@implementation MainViewController

#pragma mark - Properties

@synthesize labelObjects;

#pragma mark - Object Lifecycle

- (void)dealloc
{
    [labelObjects release];
    
    [super dealloc];
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem* debugButton = [[ECPopoverBarButtonItem alloc] initWithTitle:@"Debug" style:UIBarButtonItemStylePlain content:@"ECDebugViewPopoverController"];
    self.navigationItem.leftBarButtonItem = debugButton;
    [debugButton release];
    
    self.navigationItem.rightBarButtonItem = self.table.editButtonItem;
    
    ModelController* model = [AppDelegate sharedInstance].model;
    ECTSection* section1 = [ECTSection sectionWithProperties:@"ArraySection" boundToArrayAtPath:@"objects" object:model];
    [section1 makeAddableWithObject:@"Add Item" properties:nil];
    [self.table addSection:section1];

    [model addObserver:self forKeyPath:@"objects" options:NSKeyValueObservingOptionNew context:nil];
    
    [self updateUI];
}

- (void)viewDidUnload
{
    self.labelObjects = nil;
    
    ModelController* model = [AppDelegate sharedInstance].model;
    [model removeObserver:self forKeyPath:@"objects"];
    
    [super viewDidUnload];
}

- (void)updateUI
{
    ModelController* model = [AppDelegate sharedInstance].model;
    NSMutableString* names = [NSMutableString stringWithFormat:@"Object names:\n"];
    for (ModelObject* object in model.objects)
    {
        [names appendFormat:@"%@, ", object.name];
    }
    self.labelObjects.text = names;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self updateUI];
}

#pragma mark - Actions

- (IBAction)tappedAdd:(id)sender
{
    ModelController* model = [AppDelegate sharedInstance].model;
    NSMutableArray* array = [model mutableArrayValueForKey:@"objects"];
    ModelObject* object = [[ModelObject alloc] init];
    object.name = @"New Object";
    object.label = @"This is a newly created object";
    [array insertObject:object atIndex:0];
    [object release];
}

- (IBAction)tappedDelete:(id)sender
{
    ModelController* model = [AppDelegate sharedInstance].model;
    NSMutableArray* array = [model mutableArrayValueForKey:@"objects"];
    if ([array count] > 0)
    {
        [array removeObjectAtIndex:0];
    }
}

- (IBAction)tappedRandomise:(id)sender
{
    ModelController* model = [AppDelegate sharedInstance].model; 
    NSMutableArray* array = [model mutableArrayValueForKey:@"objects"];
    [array randomize];
}

- (IBAction)tappedReplace:(id)sender
{
    ModelController* model = [AppDelegate sharedInstance].model;
    NSMutableArray* objs = [NSMutableArray array];
    for (NSUInteger n = 0; n < 6; ++n)
    {
        ModelObject* object = [[ModelObject alloc] init];
        object.name = [NSString stringWithFormat:@"Replacement Object %d", n];
        object.label = [[NSDate date] description];
        object.option = @"Item 2";
        [objs addObject:object];
        [object release];
    }
    
    model.objects = objs;
}

@end
