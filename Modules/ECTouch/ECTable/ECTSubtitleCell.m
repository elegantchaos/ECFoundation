// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 07/09/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTSubtitleCell.h"

@implementation ECTSubtitleCell

#pragma mark - Object lifecycle

- (id)initWithBinding:(ECTBinding*)binding section:(ECTSection*)sectionIn reuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithStyle:UITableViewCellStyleSubtitle binding:binding section:sectionIn reuseIdentifier:reuseIdentifier];
}

@end
