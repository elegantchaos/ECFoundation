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

- (id<ECTTickSectionCellDelegate>)selectionDelegateForSection:(ECTSection*)section binding:(ECTBinding*)binding
{
    id<ECTTickSectionCellDelegate> delegate = nil;
    if ([section conformsToProtocol:@protocol(ECTTickSectionCellDelegate)])
    {
        delegate = (id<ECTTickSectionCellDelegate>) section;
    }
    else if ([section.table conformsToProtocol:@protocol(ECTTickSectionCellDelegate)])
    {
        delegate = (id<ECTTickSectionCellDelegate>) section.table;
    }
    
    return delegate;
}

- (BOOL)cellSelectedForSection:(ECTSection*)section binding:(ECTBinding*)binding
{
    id<ECTTickSectionCellDelegate> delegate = [self selectionDelegateForSection:section binding:binding];
    BOOL selected = delegate ? [delegate isSelectedForCell:self section:section binding:binding] : NO;
    
    return selected;
}

- (void)setupForBinding:(ECTBinding*)binding section:(ECTSection*)section
{
    [super setupForBinding:binding section:section];
    
    BOOL selected = [self cellSelectedForSection:section binding:binding];
    self.accessoryType = selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

- (SelectionMode)didSelectWithBinding:(id)binding section:(ECTSection *)section
{
    // we've been clicked
    id<ECTTickSectionCellDelegate> delegate = [self selectionDelegateForSection:section binding:binding];
    [delegate selectCell:self section:section binding:binding];

     return SelectNever;
}

@end
