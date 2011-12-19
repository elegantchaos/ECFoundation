// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECLogHandlerStderr.h"
#import "ECLogChannel.h"

#include <stdio.h>

@implementation ECLogHandlerStderr

#pragma mark - Lifecycle

// --------------------------------------------------------------------------
//! Initialise.
// --------------------------------------------------------------------------

- (id) init 
{
    if ((self = [super init]) != nil) 
    {
        self.name = @"Stderr";
    }
    
    return self;
}


#pragma mark - Logging

- (void)logFromChannel:(ECLogChannel*)channel withObject:(id)object arguments:(va_list)arguments context:(ECLogContext*)context
{
    NSString* output = [self simpleOutputStringForChannel:channel withObject:object arguments:arguments context:context];
    fprintf(stderr, "%s\n", [output UTF8String]);
}

@end
