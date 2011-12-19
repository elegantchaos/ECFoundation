// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECLogHandlerASL.h"
#import "ECLogChannel.h"

#import <asl.h>

@interface ECLogHandlerASL()

@property (nonatomic, assign) aslclient aslClient;
@property (nonatomic, assign) aslmsg aslMsg;

@end

@implementation ECLogHandlerASL

#pragma mark - Lifecycle

// --------------------------------------------------------------------------
//! Initialise.
// --------------------------------------------------------------------------

- (id) init 
{
    if ((self = [super init]) != nil) 
    {
        self.name = @"ASL";
        NSString* name = [[NSBundle mainBundle] bundleIdentifier];
        const char* name_c = [name UTF8String];
        self.aslClient = asl_open(name_c, "ECLogging", ASL_OPT_STDERR);
        self.aslMsg = asl_new(ASL_TYPE_MSG);
        asl_set(self.aslMsg, ASL_KEY_SENDER, name_c);
    }
    
    return self;
}

- (void)dealloc 
{
    asl_free(self.aslMsg);
    asl_close(self.aslClient);
    
    [super dealloc];
}

#pragma mark - Logging

- (void) logFromChannel: (ECLogChannel*) channel withFormat: (NSString*) format arguments: (va_list) arguments context:(ECLogContext *)context
{
    NSString* contextString = [channel stringFromContext:context];

    if (![channel showContext:ECLogContextMessage])
    {
        // just log the context
        asl_log(self.aslClient, self.aslMsg, ASL_LEVEL_NOTICE, "%s", [contextString UTF8String]);
    }
    else
    {
        // log the message, possibly with a context appended
        NSString* bodyString = [[NSString alloc] initWithFormat: format arguments: arguments];
        if ([contextString length])
        {
            asl_log(self.aslClient, self.aslMsg, ASL_LEVEL_NOTICE, "%s «%s»", [bodyString UTF8String], [contextString UTF8String]);
        }
        else
        {
            asl_log(self.aslClient, self.aslMsg, ASL_LEVEL_NOTICE, "%s", [bodyString UTF8String]);
        }
        [bodyString release];
    }
}

@end
