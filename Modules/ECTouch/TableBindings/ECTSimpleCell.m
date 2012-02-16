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
#import "ECTKeys.h"

#import "ECLogging.h"
#import "ECAssertion.h"
#import "UIFont+ECCore.h"

@interface ECTSimpleCell()

- (void)removeBinding;

@end


@implementation ECTSimpleCell

#pragma mark - Channels

ECDefineDebugChannel(ECTSimpleCellChannel);

#pragma mark - Properties

@synthesize canDelete;
@synthesize canMove;
@synthesize binding; // TODO should this be a weak link?
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
    if (self.binding)
    {
        ECDebug(ECTSimpleCellChannel, @"removed binding %@ from cell %@", self.binding, self);
        [self.binding removeValueObserver:self];
        self.binding = nil;
    }
}

- (void)prepareForReuse
{
    ECAssertNil(self.binding);
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
    // get image to use
    UIImage* image = [self.binding image];
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

- (void)setupFontForLabel:(UILabel*)label key:(NSString*)key info:(NSDictionary*)fontInfo
{
    NSDictionary* info = [fontInfo objectForKey:key];
    if (info)
    {
        label.font = [UIFont fontFromDictionary:info];
    }
}

- (void)setupForBinding:(ECTBinding*)newBinding section:(ECTSection*)sectionIn
{
    self.section = sectionIn;
    self.binding = newBinding;

    NSDictionary* fontInfo = [self.binding lookupKey:ECTFontKey];
    if (fontInfo)
    {
        [self setupFontForLabel:self.textLabel key:ECTLabelKey info:fontInfo];
        [self setupFontForLabel:self.detailTextLabel key:ECTDetailKey info:fontInfo];
    }
    
    [self setupAccessory];
    [self updateUIForEvent:ValueInitialised];
    [newBinding addValueObserver:self options:NSKeyValueObservingOptionNew];
}

- (void)setupAccessory
{
    UITableViewCellAccessoryType accessory;
    
    if ([self.binding lookupDisclosureKey:ECTDetailKey])
    {
        accessory = UITableViewCellAccessoryDetailDisclosureButton;
    }
    else if ([self.binding lookupDisclosureKey:ECTClassKey])
    {
        accessory = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        accessory = UITableViewCellAccessoryNone;
    }
    
    self.accessoryType = accessory;
}

- (SelectionMode)didSelect
{
    if (self.binding.actionSelector)
    {
        [[UIApplication sharedApplication] sendAction:self.binding.actionSelector to:self.binding.target from:self forEvent:nil];
    }

    return SelectIfSelectable;
}

+ (CGFloat)heightForBinding:(ECTBinding*)binding
{
    return UITableViewAutomaticDimension;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == self.binding)
    {
        [self updateUIForEvent:ValueChanged];
    }
}

@end
