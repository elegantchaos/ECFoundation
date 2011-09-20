// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECLogHandlerStdout.h"
#import "ECLogChannel.h"

#include <stdio.h>

@implementation ECLogHandlerStdout

#pragma mark - Lifecycle

// --------------------------------------------------------------------------
//! Initialise.
// --------------------------------------------------------------------------

- (id) init 
{
    if ((self = [super init]) != nil) 
    {
        self.name = @"Stdout";
    }
    
    return self;
}


#pragma mark - Logging

- (void) logFromChannel: (ECLogChannel*) channel withFormat: (NSString*) format arguments: (va_list) arguments context:(ECLogContext *)context
{
	NSString* body = [[NSString alloc] initWithFormat: format arguments: arguments];
    NSString* output = [[NSString alloc] initWithFormat:@"«%@» %@", channel.name, body];
	[body release];	
    
    printf("%s\n", [output UTF8String]);
    [output release];
}

@end
