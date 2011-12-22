// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 15/12/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECASLClient.h"

#import <asl.h>

static ECASLClient* gSharedInstance = nil;

@interface ECASLClient()

#pragma mark - Private Properties

@property (nonatomic, assign) aslclient client;
@property (nonatomic, assign) aslmsg msg;

- (void)logAtLevel:(int)level withFormat:(NSString*)format args:(va_list)args;

@end

@implementation ECASLClient

@synthesize client;
@synthesize msg;

#pragma mark - Object Lifecycle

// --------------------------------------------------------------------------
//! If an instance is alive, return a pointer to the first one.
//! This is a bit of a hacky way of ensuring that code can get
//! at an ASL client without having to have it passed in.
// --------------------------------------------------------------------------

+ (ECASLClient*)sharedInstance
{
    return gSharedInstance;
}

// --------------------------------------------------------------------------
//! Set up ASL connection etc.
// --------------------------------------------------------------------------

- (id)initWithName:(NSString*)name
{
    if ((self = [super init]) != nil)
    {
        const char* name_c = [name UTF8String];
        self.client = asl_open(name_c, "log", ASL_OPT_STDERR);
        self.msg = asl_new(ASL_TYPE_MSG);
        if (gSharedInstance == nil)
        {
            gSharedInstance = self;
        }
    }
    
    return self;
}

// --------------------------------------------------------------------------
//! Cleanup.
// --------------------------------------------------------------------------

- (void)dealloc 
{
    asl_free(self.msg);
    asl_close(self.client);
    if (gSharedInstance == self)
    {
        gSharedInstance = nil;
    }
    
    [super dealloc];
}

// --------------------------------------------------------------------------
//! Log to ASL.
// --------------------------------------------------------------------------

- (void)logAtLevel:(int)level withFormat:(NSString*)format args:(va_list)args
{
    NSString* text = [[NSString alloc] initWithFormat:format arguments:args];
    asl_log(self.client, self.msg, level, "%s", [text UTF8String]);
    [text release];
}


// --------------------------------------------------------------------------
//! Log to ASL. at a given level
// --------------------------------------------------------------------------

- (void)logAtLevel:(int)level withFormat:(NSString *)format, ...
{
    va_list args;
    va_start(args, format);
    [self logAtLevel:level withFormat:format args:args];
    va_end(args);
}

// --------------------------------------------------------------------------
//! Log info to ASL.
// --------------------------------------------------------------------------

- (void)log:(NSString*)format, ...
{
    va_list args;
    va_start(args, format);
    [self logAtLevel:ASL_LEVEL_INFO withFormat:format args:args];
    va_end(args);
}

// --------------------------------------------------------------------------
//! Log error to ASL.
// --------------------------------------------------------------------------

- (void)error:(NSString*)format, ... 
{
    va_list args;
    va_start(args, format);
    [self logAtLevel:ASL_LEVEL_INFO withFormat:format args:args];
    va_end(args);
}


@end
