// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 01/08/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECDefaultLogHandler.h"
#import "ECLogChannel.h"

@implementation ECDefaultLogHandler

- (void) logFromChannel: (ECLogChannel*) channel withFormat: (NSString*) format arguments: (va_list) arguments
{
	NSString* body = [[NSString alloc] initWithFormat: format arguments: arguments];
	NSLog(@"«%@» %@", channel.name, body);
	[body release];	
}
@end
