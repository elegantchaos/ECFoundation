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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    self.accessoryType = selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

@end
