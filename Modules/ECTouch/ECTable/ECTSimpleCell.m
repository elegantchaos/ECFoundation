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
#import "ECAssertion.h"

@interface ECTSimpleCell()

- (void)removeBinding;

@end


@implementation ECTSimpleCell

#pragma mark - Properties

@synthesize canDelete;
@synthesize canMove;
@synthesize representedObject; // TODO should this be a weak link?
@synthesize section;

#pragma mark - Object lifecycle

- (id)initWithStyle:(UITableViewCellStyle)style binding:(ECTBinding*)binding section:(ECTSection*)sectionIn reuseIdentifier:(NSString *)reuseIdentifier;
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) != nil)
    {
        self.section = sectionIn;
    }
    
    return self;
}

- (id)initWithBinding:(ECTBinding*)binding section:(ECTSection*)sectionIn reuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithStyle:UITableViewCellStyleValue1 binding:binding section:sectionIn reuseIdentifier:reuseIdentifier];
}

- (void)dealloc
{
    [self removeBinding];
    [section release];
    
    [super dealloc];
}

- (void)removeBinding
{
    ECTBinding* oldBinding = self.representedObject;
    if (oldBinding)
    {
        [oldBinding removeValueObserver:self];
        self.representedObject = nil;
    }
}

- (void)prepareForReuse
{
    [self removeBinding];
    [super prepareForReuse];
}

- (void)updateUIForEvent:(UpdateEvent)event
{
    ECTBinding* binding = self.representedObject;
    
    // get text to use for label
    NSString* label = [binding labelForSection:self.section];
    if (![label isKindOfClass:[NSString class]])
    {
        label = [label description];
    }
    
    // get text to use for detail - if it's the same as the label, don't show detail
    NSString* detail = [binding detailForSection:self.section];
    if (detail == label)
    {
        detail = nil;
    }
    
    self.canMove = [binding canMoveInSection:self.section];
    self.canDelete = [binding canDeleteInSection:self.section];
    
    self.selectionStyle = binding.enabled ? UITableViewCellSelectionStyleBlue : UITableViewCellSelectionStyleNone;
    
    self.textLabel.enabled = binding.enabled;

    BOOL changed = NO;
    NSString* oldLabel = self.textLabel.text;
    if (![oldLabel isEqualToString:label])
    {
        self.textLabel.text = label;
        changed = YES;
    }
    
    if (detail)
    {
        if (![detail isKindOfClass:[NSString class]])
        {
            detail = [detail description];
        }
        self.detailTextLabel.enabled = binding.enabled;
        NSString* oldDetail = self.detailTextLabel.text;
        if (![oldDetail isEqualToString:detail])
        {
            self.detailTextLabel.text = detail;
            changed = YES;
        }
    }
    
    if (changed)
    {
        if (event == ValueChanged)
        {
            [self layoutSubviews];
        }
    }
    
}

- (void)setupForBinding:(ECTBinding*)binding section:(ECTSection*)sectionIn
{
    self.section = sectionIn;
    [self setupAccessoryForBinding:binding section:sectionIn];

    self.representedObject = binding;
    [self updateUIForEvent:ValueInitialised];
    
    [binding addValueObserver:self options:NSKeyValueObservingOptionNew];
}

- (void)setupAccessoryForBinding:(ECTBinding *)binding section:(ECTSection *)sectionIn
{
    ECAssert(self.section == sectionIn);

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

- (void)willDisplayForBinding:(ECTBinding *)binding section:(ECTSection *)section
{
    
}

- (SelectionMode)didSelectWithBinding:(ECTBinding*)binding section:(ECTSection *)section
{
    if (binding.target && binding.action)
    {
        [binding.target performSelector:binding.action withObject:binding];
    }

    return SelectIfSelectable;
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    ECTBinding* binding = self.representedObject;
    if (context == binding)
    {
        [self updateUIForEvent:ValueChanged];
    }
}

@end
