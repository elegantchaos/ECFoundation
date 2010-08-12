//
//  UIWindow+ECUtilities.m
//  ECFoundation
//
//  Created by Sam Deane on 12/08/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//

#import "UIWindow+ECUtilities.h"


@implementation UIWindow (ECUtilities)

- (void) sizeRootViewToFitWindow
{
	CGRect frame = [self frame];
	[[self.subviews objectAtIndex: 0] setFrame: frame];
}

@end
