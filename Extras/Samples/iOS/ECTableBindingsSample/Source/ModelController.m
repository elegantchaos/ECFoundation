//
//  ModelController.m
//  ECTableBindingsSample
//
//  Created by Sam Deane on 14/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ModelController.h"
#import "ModelObject.h"

@implementation ModelController

@synthesize objects;

- (id)init
{
    if ((self = [super init]) != nil)
    {
        NSMutableArray* objs = [NSMutableArray array];
        for (NSUInteger n = 0; n < 10; ++n)
        {
            ModelObject* object = [[ModelObject alloc] init];
            object.name = [NSString stringWithFormat:@"Object %d", n];
            object.label = [NSString stringWithFormat:@"label for object %d", n];
            [objs addObject:object];
            [object release];
        }
        
        self.objects = objs;
    }
    
    return self;
}

- (void)dealloc
{
    [objects release];
    
    [super dealloc];
}

@end
