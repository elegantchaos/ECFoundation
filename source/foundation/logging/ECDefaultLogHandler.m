// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 01/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
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
