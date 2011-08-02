//
//  ECLogViewHandlerItem.m
//  ECLoggingSample
//
//  Created by Sam Deane on 02/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ECLogViewHandlerItem.h"

@implementation ECLogViewHandlerItem

@synthesize channel;
@synthesize message;

- (void)dealloc 
{
    [channel release];
    [message release];
    
    [super dealloc];
}

@end
