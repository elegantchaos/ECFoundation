// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTSection.h"

// --------------------------------------------------------------------------
//! Simple cell conforming to the ECTSectionDrivenTableCell protocol.
// --------------------------------------------------------------------------

@interface ECTSimpleCell : UITableViewCell<ECTSectionDrivenTableCell>

@property (nonatomic, retain) ECTBinding* representedObject;
@property (nonatomic, assign) BOOL canDelete;
@property (nonatomic, assign) BOOL canMove;

- (id)initWithBinding:(ECTBinding*)binding section:(ECTSection*)section reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setupForBinding:(ECTBinding*)binding section:(ECTSection*)section;
- (BOOL)canDeleteInSection:(ECTSection*)section;
- (BOOL)canMoveInSection:(ECTSection*)section;

@end
