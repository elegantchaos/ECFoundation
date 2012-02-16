/// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 06/07/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTTickCell.h"

#import "ECTBinding.h"
#import "ECTSection.h"

@implementation ECTTickCell

- (void)setupForBinding:(ECTBinding*)binding section:(ECTSection*)section
{
    [super setupForBinding:binding section:section];
    
    id currentValue = section.binding.value;
    BOOL selected = [currentValue isEqual:binding.object];
    self.accessoryType = selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    self.accessoryType = selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    //[super setSelected:selected animated:animated];
}

@end
