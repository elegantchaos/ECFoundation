//
//  ECLogChannel.m
//  ECFoundation
//
//  Created by Sam Deane on 26/08/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//

#import "ECLogChannel.h"


@implementation ECLogChannel

ECPropertySynthesize(enabled);
ECPropertySynthesize(name);

- (void) logWithFormat: (NSString*) format arguments: (va_list) arguments;
{
	NSString* body = [[NSString alloc] initWithFormat: format arguments: arguments];
	NSLog(@"«%@» %@", self.name, body);
	[body release];
}

- (void) dealloc
{
	ECPropertyDealloc(name);
	
	[super dealloc];
}

@end
