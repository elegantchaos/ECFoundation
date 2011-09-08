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
	NSLog(@"«%@» %@", channel.name, body);
	[body release];	
}
@end
