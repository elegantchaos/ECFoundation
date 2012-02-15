/// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 06/07/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTSimpleCell.h"

@interface ECTTickCell : ECTSimpleCell

@end

@protocol ECTTickSectionCellDelegate <NSObject>

- (BOOL)isSelectedForCell:(ECTTickCell*)cell binding:(ECTBinding*)binding;
- (void)selectCell:(ECTTickCell*)cell binding:(ECTBinding*)binding;

@end
