// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/10/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "UIFont+ECCore.h"
#import "ECLogging.h"

@implementation UIFont(ECCore)

ECDefineDebugChannel(FontChannel);

- (UIFont*)boldVariant
{
    UIFont* result = self;
    NSArray* styles = [UIFont fontNamesForFamilyName:self.familyName];
    
    ECDebug(FontChannel, @"available styles for %@: %@", self, styles);
    
    for (NSString* name in styles)
    {
        if ([name rangeOfString:@"bold" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            if (([name rangeOfString:@"italic" options:NSCaseInsensitiveSearch].location == NSNotFound)
                && ([name rangeOfString:@"oblique" options:NSCaseInsensitiveSearch].location == NSNotFound))
            {
                result = [UIFont fontWithName:name size:self.pointSize];
                break;
            }
        }
    }

    return result;
}

@end
