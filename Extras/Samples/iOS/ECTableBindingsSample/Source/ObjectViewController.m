// --------------------------------------------------------------------------
//! @author Sam Deane
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ObjectViewController.h"

#import "ECTBinding.h"
#import "ECTSection.h"
#import "ECTButtonCell.h"
#import "ModelObject.h"

@interface ObjectViewController ()

@property (strong, nonatomic) ECTBinding* binding;

@end

@implementation ObjectViewController

@synthesize binding;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [binding release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    // make the same section twice, to prove that edits on the object in one section will be reflected in the other one
    ECTSection* section1 = [ECTSection sectionWithProperties:@"ObjectSection" boundToObject:self.binding.object];
    ECTSection* section2 = [ECTSection sectionWithProperties:@"ObjectSection" boundToObject:self.binding.object];
    section2.footer = @"This is another section representing the same object. If you edit the object value in one section, the other one should update.";
    
    [self.table addSection:section1];
    [self.table addSection:section2];
}

- (void)setupForBinding:(ECTBinding*)bindingIn
{
    self.binding = bindingIn;
}

#pragma mark - Actions

- (IBAction)tappedButton:(id)sender
{
    // when the button it tapped, we modify the label of the model object bound to the cell
    ECTButtonCell* cell = sender;
    ECTBinding* cellBinding = cell.representedObject;
    ModelObject* object = cellBinding.object;
    object.label = [NSString stringWithFormat:@"Button was clicked at %@", [NSDate date]];
}

@end
