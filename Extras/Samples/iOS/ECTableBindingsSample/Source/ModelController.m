// --------------------------------------------------------------------------
//! @author Sam Deane
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ModelController.h"
#import "ModelObject.h"

@implementation ModelController

@synthesize objects;

- (void)startup
{
    NSMutableArray* objs = [NSMutableArray array];
    for (NSUInteger n = 0; n < 10; ++n)
    {
        ModelObject* object = [[ModelObject alloc] init];
        object.name = [NSString stringWithFormat:@"Object %d", n];
        object.label = [NSString stringWithFormat:@"label for object %d", n];
        object.option = @"Item 1";
        [objs addObject:object];
        [object release];
    }
    
    self.objects = objs;
}

- (void)shutdown
{
    self.objects = nil;
}

@end
