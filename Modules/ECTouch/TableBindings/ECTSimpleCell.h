// --------------------------------------------------------------------------
//! @author Sam Deane
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTSection.h"

// --------------------------------------------------------------------------
//! Simple cell conforming to the ECTSectionDrivenTableCell protocol.
// --------------------------------------------------------------------------

typedef enum
{
    ValueInitialised,
    ValueChanged
} UpdateEvent;

@interface ECTSimpleCell : UITableViewCell<ECTSectionDrivenTableCell>

@property (nonatomic, retain) ECTBinding* representedObject;
@property (nonatomic, retain) ECTSection* section;
@property (nonatomic, assign) BOOL canDelete;
@property (nonatomic, assign) BOOL canMove;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier;
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
- (void)setupForBinding:(ECTBinding*)binding section:(ECTSection*)section;
- (void)removeBinding;
- (void)setupAccessoryForBinding:(ECTBinding*)binding;
- (BOOL)canDelete;
- (BOOL)canMove;
- (void)updateUIForEvent:(UpdateEvent)event;

@end
