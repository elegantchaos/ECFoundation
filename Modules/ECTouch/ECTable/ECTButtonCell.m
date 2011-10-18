// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTButtonCell.h"
#import "ECTBinding.h"

@interface ECTButtonCell()


@end

@implementation ECTButtonCell

#pragma mark - Debug channels

ECDefineDebugChannel(ECTButtonCellChannel);

#pragma mark - Properties

@synthesize buttonControl;

#pragma mark - Constants

static CGFloat kHorizontalInset = 0;    // TODO make these properties?
static CGFloat kVerticalInset = 0;

#pragma mark - Object lifecycle

- (id)initWithBinding:(ECTBinding*)binding section:(ECTSection*)section reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) != nil)
    {
        UIButton* button = [UIButton buttonWithType:[self buttonType]];
        [button addTarget:binding.target action:binding.action forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(kHorizontalInset, kVerticalInset, self.contentView.frame.size.width - (2 * kHorizontalInset), self.contentView.frame.size.height - (2 * kVerticalInset));
        [self.contentView addSubview:button];
        button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.buttonControl = button;
    }
    
    return self;
}

- (void)dealloc
{
    [buttonControl release];
    
    [super dealloc];
}

#pragma mark - ECTSimpleSectionCell methods

- (void)setupForBinding:(ECTBinding*)binding section:(ECTSection*)section
{
    self.representedObject = binding;
    NSString* label = [binding labelForSection:section];
    [self.buttonControl setTitle:label forState:UIControlStateNormal];
}

#pragma mark - Internal

- (UIButtonType)buttonType
{
    return UIButtonTypeRoundedRect;
}


@end
