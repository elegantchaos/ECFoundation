// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECLogHandlerNSLog.h"
#import "ECLogChannel.h"

@implementation ECLogHandlerNSLog

#pragma mark - Lifecycle

// --------------------------------------------------------------------------
//! Initialise.
// --------------------------------------------------------------------------

- (id) init 
{
    if ((self = [super init]) != nil) 
    {
        self.name = @"NSLog";
    }
    
    return self;
}


#pragma mark - Logging

- (void) logFromChannel: (ECLogChannel*) channel withFormat: (NSString*) format arguments: (va_list) arguments context:(ECLogContext *)context
{
	NSString* body = [[NSString alloc] initWithFormat: format arguments: arguments];
    
    if (channel.context)
    {
        NSMutableString* contextString = [[NSMutableString alloc] init];

        if ([channel showContext:ECLogContextName])
        {
            [contextString appendString:[NSString stringWithFormat:@"%@ ", channel.name]];
        }

        if ([channel showContext:ECLogContextFile])
        {
            [contextString appendString:[NSString stringWithFormat:@"%s ", context->file]];
        }

        if ([channel showContext:ECLogContextLine])
        {
            [contextString appendString:[NSString stringWithFormat:@"%d ", context->line]];
        }

        if ([channel showContext:ECLogContextFunction])
        {
            [contextString appendString:[NSString stringWithFormat:@"%s ", context->function]];
        }

        NSUInteger length = [contextString length];
        if (length > 0)
        {
            [contextString deleteCharactersInRange:NSMakeRange(length - 1, 1)]; 
        }
        
        NSLog(@"«%@» %@", contextString, body);
        [contextString release];
    }
    else
    {
        NSLog(@"%@", body);
    }
	[body release];	
}
@end
