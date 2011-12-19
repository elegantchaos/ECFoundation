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

#import "NSString+ECCore.h"

static NSString *const kSuffixToStrip = @"Channel";

// --------------------------------------------------------------------------
// Private Methods
// --------------------------------------------------------------------------

@interface ECLogChannel()
@end

@implementation ECLogChannel

@synthesize context;
@synthesize enabled;
@synthesize handlers;
@synthesize level;
@synthesize name;
@synthesize setup;

#pragma mark - Lifecycle

// --------------------------------------------------------------------------
//! Initialse a channel.
// --------------------------------------------------------------------------

- (id) initWithName:(NSString*)nameIn
{
	if ((self = [super init]) != nil)
	{
		self.name = nameIn;
        self.context = ECLogContextDefault;
        self.level = kUndefinedLevel;
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
        logToChannel(self, &ecLogContext, @"enabled channel");
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
        logToChannel(self, &ecLogContext, @"disabled channel");
        self.enabled = NO;
    }
}

#pragma mark - Handlers

// --------------------------------------------------------------------------
//! Add a handler to the set of handlers we're logging to.
// --------------------------------------------------------------------------

- (void) enableHandler: (ECLogHandler*)handler
{
    if (!self.handlers)
    {
        self.handlers = [NSMutableSet setWithObject:handler];
    }
    else
    {
        [self.handlers addObject:handler];
    }
    
    ECMakeContext();
    logToChannel(self, &ecLogContext, @"Enabled handler %@", handler.name);
}

// --------------------------------------------------------------------------
//! Remove a handler from the set of handlers we're logging to.
// --------------------------------------------------------------------------

- (void) disableHandler: (ECLogHandler*) handler
{
    ECMakeContext();
    logToChannel(self, &ecLogContext, @"Disabled handler %@", handler.name);
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

// --------------------------------------------------------------------------
//! Should we show the given context item(s) in this channel?
// --------------------------------------------------------------------------

- (BOOL)showContext:(ECLogContextFlags)flagsToTest
{
    ECLogContextFlags flagsSet = self.context;
    if (flagsSet == ECLogContextDefault)
    {
        flagsSet = [[ECLogManager sharedInstance] defaultContextFlags];
    }
    
    return (flagsToTest & flagsSet) == flagsToTest;
}

// --------------------------------------------------------------------------
//! Return a formatted string giving the file name and line number from a 
//! context structure.
// --------------------------------------------------------------------------

- (NSString*) fileFromContext:(ECLogContext*)contextIn
{
    NSString* file = [NSString stringWithCString:contextIn->file encoding:NSUTF8StringEncoding];
    if (![self showContext:ECLogContextFullPath])
    {
        file = [file lastPathComponent];
    }
    
    return [NSString stringWithFormat:@"%@, %d", file, contextIn->line];
}

// --------------------------------------------------------------------------
//! Return a formatted string describing a context structure, based on our
//! context flags.
// --------------------------------------------------------------------------

- (NSString*)stringFromContext:(ECLogContext *)contextIn
{
    NSString* result;
    if (self.context)
    {
        NSMutableString* string = [[[NSMutableString alloc] init] autorelease];
        
        if ([self showContext:ECLogContextName])
        {
            [string appendString:[NSString stringWithFormat:@"%@ ", self.name]];
        }
        
        if ([self showContext:ECLogContextFile])
        {
            [string appendString:[NSString stringWithFormat:@"%@ ", [self fileFromContext:contextIn]]];
        }
        
        if ([self showContext:ECLogContextFunction])
        {
            [string appendString:[NSString stringWithFormat:@"%s ", contextIn->function]];
        }
        
        NSUInteger length = [string length];
        if (length > 0)
        {
            [string deleteCharactersInRange:NSMakeRange(length - 1, 1)]; 
        }
        result = string;
    }
    else
    {
        result = @"";
    }

    return result;
}

// --------------------------------------------------------------------------
//! UI helper - should we tick a menu item for a given flag index?
// --------------------------------------------------------------------------

- (BOOL)tickFlagWithIndex:(NSUInteger)index
{
    BOOL ticked;
    ECLogManager* lm = [ECLogManager sharedInstance];
    ECLogContextFlags rowFlag = [lm contextFlagValueForIndex:index];
    if (self.context == ECLogContextDefault)
    {
        ticked = rowFlag == ECLogContextDefault;
    }
    else
    {
        ticked = [self showContext:rowFlag];
    }
    
    return ticked;
}

// --------------------------------------------------------------------------
//! UI helper - respond to a context flag being selected.
// --------------------------------------------------------------------------

- (void)selectFlagWithIndex:(NSUInteger)index
{
    ECLogManager* lm = [ECLogManager sharedInstance];
    ECLogContextFlags selectedFlag = [lm contextFlagValueForIndex:index];
    
    // if it's the default flag we're playing with, then we want to clear out all
    // other flags; if it's any other flag, we want to clear out the default flag
    if (selectedFlag == ECLogContextDefault)
    {
        self.context &= ECLogContextDefault;
    }
    else
    {
        self.context &= ~ECLogContextDefault;
    }
    
    // toggle the flag that was actually selected
    self.context ^= selectedFlag;

    [lm saveChannelSettings];
}

// --------------------------------------------------------------------------
//! UI helper - should we tick a menu item for a given handler index?
// --------------------------------------------------------------------------

- (BOOL)tickHandlerWithIndex:(NSUInteger)index
{
    BOOL ticked;
    if (index == 0)
    {
        ticked = self.handlers == nil;
    }
    else
    {
        ECLogManager* lm = [ECLogManager sharedInstance];
        ECLogHandler* handler = [lm handlerForIndex:index];
        ticked = self.handlers && [self isHandlerEnabled:handler];
    }
    
    return ticked;
}

// --------------------------------------------------------------------------
//! UI helper - respond to a handler being selected.
// --------------------------------------------------------------------------

- (void)selectHandlerWithIndex:(NSUInteger)index
{
    ECLogManager* lm = [ECLogManager sharedInstance];
    if (index == 0)
    {
        self.handlers = nil;
    }
    else
    {
        ECLogHandler* handler = [lm handlerForIndex:index];
        if (self.handlers && [self isHandlerEnabled:handler]) 
        {
            [self disableHandler:handler];
        }
        else
        {
            [self enableHandler:handler];
        }
    }
    
    [lm saveChannelSettings];
}

@end
