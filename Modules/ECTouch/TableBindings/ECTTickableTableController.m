// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 06/07/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTTickableTableController.h"
#import "ECTSection.h"
#import "ECTBinding.h"
#import "ECTTickCell.h"
#import "ECLogging.h"

#pragma mark - Private Interface

@interface ECTTickableTableController()

@end

@implementation ECTTickableTableController

@synthesize autoPop;

#pragma mark - Debug Channels

ECDefineDebugChannel(ECTTickableTableControllerChannel);

#pragma mark - Properties


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupSections];
}


#pragma mark - To Be Overridden

- (void)setupSections
{
}

#pragma mark - ECTTickSectionCellDelegate methods

- (BOOL)isSelectedForCell:(ECTTickCell*)cell binding:(ECTBinding*)binding
{
    id currentValue = self.representedObject.objectValue;
    return [currentValue isEqual:binding.object];
}

- (void)selectCell:(ECTTickCell*)cell binding:(ECTBinding*)binding
{
    ECDebug(ECTTickableTableControllerChannel, @"cell selected %@ %@", binding, binding.object);
    self.representedObject.objectValue = binding.object;
    [cell.section reloadData];
    
    if (self.autoPop)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
