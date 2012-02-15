//
//  ObjectViewController.m
//  ECTableBindingsSample
//
//  Created by Sam Deane on 14/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ObjectViewController.h"

#import "ECTBinding.h"
#import "ECTSection.h"

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
    ECTSection* section = [ECTSection sectionWithProperties:@"ObjectSection" boundToObject:self.binding.object];
    [self.table addSection:section];
}

- (void)setupForBinding:(ECTBinding*)bindingIn
{
    self.binding = bindingIn;
}

@end