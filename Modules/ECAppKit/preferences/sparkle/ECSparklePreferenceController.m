// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 16/01/2010
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECSparklePreferenceController.h"

@implementation ECSparklePreferenceController

@synthesize introText = _introText;
@synthesize anonymousText = _anonymousText;

+ (NSArray*) preferencePanes
{
    return [NSArray arrayWithObjects:[[[ECSparklePreferenceController alloc] init] autorelease], nil];
}

- (NSString*) paneName
{
    return @"Updates";
}

- (NSString*) paneToolTip
{
    return @"Automatic Updates";
}

- (id) init
{
	if ((self = [super init]) != nil)
	{
		NSString* name = [[[NSBundle mainBundle] infoDictionary] objectForKey: @"CFBundleName"];
		self.introText = [NSString stringWithFormat: @"%@ can automatically check for updates of itself. Checking occurs only when a network connection is active.", name];
		self.anonymousText = [NSString stringWithFormat: @"To help us improve support for all platforms, %@ can include anonymous information about your current configuration every time it checks for an update.", name];
	}
	
	return self;
}

- (void) dealloc
{
	[_introText release];
	[_anonymousText release];
	
	[super dealloc];
}

@end
