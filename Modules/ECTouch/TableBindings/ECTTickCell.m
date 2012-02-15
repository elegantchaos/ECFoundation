/// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 06/07/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTTickCell.h"

@implementation ECTTickCell

- (id<ECTTickSectionCellDelegate>)selectionDelegateForBinding:(ECTBinding*)binding
{
    id<ECTTickSectionCellDelegate> delegate = nil;
    if ([self.section conformsToProtocol:@protocol(ECTTickSectionCellDelegate)])
    {
        delegate = (id<ECTTickSectionCellDelegate>) self.section;
    }
    else if ([self.section.table conformsToProtocol:@protocol(ECTTickSectionCellDelegate)])
    {
        delegate = (id<ECTTickSectionCellDelegate>) self.section.table;
    }
    
    return delegate;
}

- (BOOL)cellSelectedForSection:(ECTSection*)section binding:(ECTBinding*)binding
{
    id<ECTTickSectionCellDelegate> delegate = [self selectionDelegateForBinding:binding];
    BOOL selected = delegate ? [delegate isSelectedForCell:self binding:binding] : NO;
    
    return selected;
}

- (void)setupForBinding:(ECTBinding*)binding section:(ECTSection*)section
{
    [super setupForBinding:binding section:section];
    
    BOOL selected = [self cellSelectedForSection:section binding:binding];
    self.accessoryType = selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

- (SelectionMode)didSelect
{
    // we've been clicked
    id<ECTTickSectionCellDelegate> delegate = [self selectionDelegateForBinding:self.binding];
    [delegate selectCell:self binding:self.binding];

     return SelectNever;
}

@end
