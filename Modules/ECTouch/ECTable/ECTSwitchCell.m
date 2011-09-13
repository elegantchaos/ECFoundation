// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTSwitchCell.h"
#import "ECTBinding.h"

@interface ECTSwitchCell()

@property (nonatomic, retain) UISwitch* switchControl;

- (IBAction)switched:(id)sender;

@end

@implementation ECTSwitchCell

#pragma mark - Debug channels

ECDefineDebugChannel(ECTSwitchSectionCellChannel);

#pragma mark - Properties

@synthesize switchControl;

#pragma mark - Object lifecycle

- (id)initWithBinding:(ECTBinding*)binding section:(ECTSection*)section reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) != nil)
    {
        UISwitch* view = [[UISwitch alloc] initWithFrame:CGRectZero];
        [view addTarget:self action:@selector(switched:) forControlEvents:UIControlEventValueChanged];
        self.accessoryView = view;
        self.switchControl = view;
        [view release];
    }
    
    return self;
}

- (void)dealloc
{
    [switchControl release];
    
    [super dealloc];
}

#pragma mark - ECTSimpleSectionCell methods

- (void)setupForBinding:(ECTBinding*)binding section:(ECTSection*)section
{
    [super setupForBinding:binding section:section];
    NSNumber* value = (NSNumber*)[binding valueForSection:section];
    self.switchControl.on = [value boolValue];
}

#pragma mark - Actions

- (IBAction)switched:(id)sender
{
    ECDebug(ECTSwitchSectionCellChannel, @"switch %@ to %d", self.switchControl, switchControl.on); 
    
    [self.representedObject didSetValue:[NSNumber numberWithBool:switchControl.on] forCell:self];
}

@end
