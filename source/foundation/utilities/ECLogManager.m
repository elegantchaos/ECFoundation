//
//  ECLogManager.m
//  ECFoundation
//
//  Created by Sam Deane on 26/08/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//

#import "ECLogManager.h"
#import "ECLogChannel.h"

@implementation ECLogManager

ECPropertySynthesize(channels);

+ (ECLogManager*) sharedInstance
{
	static ECLogManager* instance = nil;
	
	if (!instance)
	{
		instance = [[ECLogManager alloc] init];
	}
	
	return instance;
}

- (void) registerChannel: (ECLogChannel*) channel
{
	NSLog(@"added log channel: %@", channel.name);
	[self.channels addObject: channel];
}

- (id) init
{
	if ((self = [super init]) != nil)
	{
		NSMutableArray* array = [[NSMutableArray alloc] init];
		self.channels = array;
		[array release];
	}
	
	return self;
}

- (void) dealloc
{
	ECPropertyDealloc(channels);
	
	[super dealloc];
}
@end
