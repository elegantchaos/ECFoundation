// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECLogChannel.h"
#import "ECLogHandler.h"
#import "ECLogging.h"
#import "ECLogManager.h"

#import "NSString+ECUtilities.h"

static NSString *const kSuffixToStrip = @"Channel";

// --------------------------------------------------------------------------
// Private Methods
// --------------------------------------------------------------------------

@interface ECLogChannel()
@end

@implementation ECLogChannel

@synthesize enabled;
@synthesize setup;
@synthesize name;
@synthesize handlers;

#pragma mark - Lifecycle

// --------------------------------------------------------------------------
//! Initialse a channel.
// --------------------------------------------------------------------------

- (id) initWithName:(NSString*)nameIn
{
	if ((self = [super init]) != nil)
	{
		self.name = nameIn;
	}
	
	return self;
}

// --------------------------------------------------------------------------
//! Clean up and release retained objects.
// --------------------------------------------------------------------------

- (void) dealloc
{
	[name release];
	[handlers release];
    
	[super dealloc];
}

#pragma mark - Enable/Disable

// --------------------------------------------------------------------------
//! Enable the channel.
//! If it has no handlers enabled, we enable the default one so that it has
//! something to output to.
// --------------------------------------------------------------------------

- (void) enable
{
    if (!self.enabled)
    {
        self.enabled = YES;
        ECMakeContext(); 
        logToChannel(self, &context, @"enabled channel");
    }
}

// --------------------------------------------------------------------------
//! Disable the channel.
// --------------------------------------------------------------------------

- (void) disable
{
    if (self.enabled)
    {
        ECMakeContext(); 
        logToChannel(self, &context, @"disabled channel");
        self.enabled = NO;
    }
}

#pragma mark - Handlers

// --------------------------------------------------------------------------
//! Add a handler to the set of handlers we're logging to.
// --------------------------------------------------------------------------

- (void) enableHandler: (ECLogHandler*) handler
{
    if (!self.handlers)
    {
        self.handlers = [NSMutableSet setWithCapacity:1];
    }
    
    [self.handlers addObject:handler];
    ECMakeContext();
    logToChannel(self, &context, @"Enabled handler %@", handler.name);
}

// --------------------------------------------------------------------------
//! Remove a handler from the set of handlers we're logging to.
// --------------------------------------------------------------------------

- (void) disableHandler: (ECLogHandler*) handler
{
    ECMakeContext();
    logToChannel(self, &context, @"Disabled handler %@", handler.name);
    if (!self.handlers)
    {
        ECLogManager* lm = [ECLogManager sharedInstance];
        self.handlers = [NSMutableSet setWithArray:[lm.handlers allValues]];
    }

    [self.handlers removeObject:handler];
}

// --------------------------------------------------------------------------
//! Is a handler in the set of handlers we're logging to.
// --------------------------------------------------------------------------

- (BOOL) isHandlerEnabled:( ECLogHandler*) handler
{
    return !self.handlers || [self.handlers containsObject: handler];
}


#pragma mark - Utilities

// --------------------------------------------------------------------------
//! Return a cleaned up version of a raw channel name.
// --------------------------------------------------------------------------

+ (NSString*) cleanName:(const char *) name;
{
	NSString* temp = [NSString stringWithUTF8String: name];

	if ([temp hasSuffix: kSuffixToStrip])
	{
		temp = [temp substringToIndex: [temp length] - [kSuffixToStrip length]];
	}
	
	return [temp stringBySplittingMixedCaps];
}

// --------------------------------------------------------------------------
//! Comparison function for sorting alphabetically by name.
// --------------------------------------------------------------------------

- (NSComparisonResult) caseInsensitiveCompare: (ECLogChannel*) other
{
	return [self.name caseInsensitiveCompare: other.name];
}

@end
