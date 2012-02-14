//
//  ModelObject.m
//  ECTableBindingsSample
//
//  Created by Sam Deane on 14/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ModelObject.h"

@implementation ModelObject

@synthesize name;
@synthesize label;

- (void)dealloc
{
    [name release];
    [label release];
    
    [super dealloc];
}

@end
