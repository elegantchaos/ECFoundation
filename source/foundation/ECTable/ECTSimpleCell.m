// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTSimpleCell.h"
#import "ECTSection.h"
#import "ECTBinding.h"


@implementation ECTSimpleCell

#pragma mark - Properties

@synthesize canDelete;
@synthesize canMove;
@synthesize representedObject; // TODO should this be a weak link?

#pragma mark - Object lifecycle

- (id)initWithBinding:(ECTBinding*)binding section:(ECTSection*)section reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) != nil)
    {
        UITableViewCellAccessoryType accessory;
        
        if ([section disclosureClassForBinding:binding detail:YES])
        {
            accessory = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if ([section disclosureClassForBinding:binding detail:NO])
        {
            accessory = UITableViewCellAccessoryDisclosureIndicator;
        }
        else
        {
            accessory = UITableViewCellAccessoryNone;
        }
        
        self.accessoryType = accessory;
    }
    
    return self;
}

- (void)dealloc
{
    [representedObject release];
    
    [super dealloc];
}

- (void)setupForBinding:(ECTBinding*)binding section:(ECTSection*)section
{
    NSString* label = [binding labelForSection:section];
    self.canMove = [binding canMoveInSection:section];
    self.canDelete = [binding canDeleteInSection:section];
    
    if (![label isKindOfClass:[NSString class]])
    {
        label = [label description];
    }
    
    self.textLabel.text = label;
    self.representedObject = binding;
}

- (void)willDisplayForBinding:(ECTBinding *)binding section:(ECTSection *)section
{
    
}

- (BOOL)didSelectWithBinding:(ECTBinding*)binding section:(ECTSection *)section
{
    return NO;
}

- (BOOL)canDeleteInSection:(ECTSection*)section
{
    return self.canDelete;
}

- (BOOL)canMoveInSection:(ECTSection*)section
{
    return self.canMove;
}

+ (CGFloat)heightForBinding:(ECTBinding*)binding section:(ECTSection*)section
{
    return section.tableView.rowHeight;
}

@end
