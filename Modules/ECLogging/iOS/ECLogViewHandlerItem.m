//
//  ECLogViewHandlerItem.m
//  ECLoggingSample
//
//  Created by Sam Deane on 02/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ECLogViewHandlerItem.h"
#import "ECLogChannel.h"

@implementation ECLogViewHandlerItem

@synthesize context;
@synthesize message;

- (void)dealloc 
{
    [context release];
    [message release];
    
    [super dealloc];
}

@end
