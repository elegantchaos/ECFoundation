// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 26/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECLogManager.h"
#import "ECLogChannel.h"

@implementation ECLogManager

// --------------------------------------------------------------------------
// Notifications
// --------------------------------------------------------------------------

NSString *const LogChannelsChanged = @"LogChannelsChanged";

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

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
	[[NSNotificationCenter defaultCenter] postNotificationName: LogChannelsChanged object: self];
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
