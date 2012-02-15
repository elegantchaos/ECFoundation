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

#pragma mark - Channels

ECDefineDebugChannel(ECTSimpleCellChannel);

#pragma mark - Properties

@synthesize canDelete;
@synthesize canMove;
@synthesize representedObject; // TODO should this be a weak link?
@synthesize section;

#pragma mark - Object lifecycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) != nil)
    {
        ECDebug(ECTSimpleCellChannel, @"new cell %@", self);
    }
    
    return self;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
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
        ECDebug(ECTSimpleCellChannel, @"removed binding %@ from cell %@", oldBinding, self);
        [oldBinding removeValueObserver:self];
        self.representedObject = nil;
    }
}

- (void)prepareForReuse
{
    ECAssertNil(self.representedObject);
    [super prepareForReuse];
    ECDebug(ECTSimpleCellChannel, @"reusing cell %@", self);

}

- (void)didMoveToSuperview
{
    if (self.superview == nil)
    {
        [self removeBinding];
        ECDebug(ECTSimpleCellChannel, @"removed cell %@", self);
    }
    [super didMoveToSuperview];
}

- (void)updateUIForEvent:(UpdateEvent)event
{
    ECTBinding* binding = self.representedObject;
    
    // get image to use
    UIImage* image = [binding image];
    self.imageView.image = image;
    
    // get text to use for label
    NSString* label = [binding label];
    if (![label isKindOfClass:[NSString class]])
    {
        label = [label description];
    }
    
    // get text to use for detail - if it's the same as the label, don't show detail
    NSString* detail = [binding detail];
    if (detail == label)
    {
        detail = nil;
    }
    
    self.canMove = [binding canMove];
    self.canDelete = [binding canDelete];
    
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

- (void)setupObserverForBinding:(ECTBinding*)binding
{
    [binding addValueObserver:self options:NSKeyValueObservingOptionNew];
}

- (void)setupForBinding:(ECTBinding*)binding section:(ECTSection*)sectionIn
{
    self.section = sectionIn;
    [self setupAccessoryForBinding:binding];

    self.representedObject = binding;
    [self updateUIForEvent:ValueInitialised];
    [self setupObserverForBinding:binding];
}

- (void)setupAccessoryForBinding:(ECTBinding *)binding
{
    UITableViewCellAccessoryType accessory;
    
    if (binding.detailDisclosureClass)
    {
        accessory = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (binding.disclosureClass)
    {
        accessory = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        accessory = UITableViewCellAccessoryNone;
    }
    
    self.accessoryType = accessory;
}

- (SelectionMode)didSelectWithBinding:(ECTBinding*)binding
{
    if (binding.target && binding.action)
    {
        [binding.target performSelector:binding.actionSelector withObject:binding];
    }

    return SelectIfSelectable;
}

- (BOOL)canDelete
{
    return self.canDelete;
}

- (BOOL)canMove
{
    return self.canMove;
}

+ (CGFloat)heightForBinding:(ECTBinding*)binding
{
    return UITableViewAutomaticDimension;
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
