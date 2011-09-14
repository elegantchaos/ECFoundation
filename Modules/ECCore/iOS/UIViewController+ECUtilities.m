// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "UIViewController+ECUtilities.h"


@implementation UIViewController(ECUtilities)

// --------------------------------------------------------------------------
//! Is this view going away?
//! Returns NO if it's still in the navigation stack.
// --------------------------------------------------------------------------

- (BOOL)willGoAway
{
    BOOL result = YES;
    if (self.navigationController)
    {
        result = ![self.navigationController.viewControllers containsObject:self];
    }
    
    return result;
}

@end
