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
@property (nonatomic, retain) NSMutableDictionary*  aslMsgs;

@end

@implementation ECLogHandlerASL

@synthesize aslClient;
@synthesize aslMsgs;

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
        self.aslMsgs = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)dealloc 
{
    for (NSValue* msg in [self.aslMsgs allValues])
    {
        asl_free([msg pointerValue]);
    }
    [aslMsgs release];
    asl_close(self.aslClient);
    
    [super dealloc];
}

#pragma mark - Logging

- (void)logFromChannel:(ECLogChannel*)channel withObject:(id)object arguments:(va_list)arguments context:(ECLogContext *)context
{
    aslmsg aslMsg = [[self.aslMsgs objectForKey:channel.name] pointerValue];
    if (!aslMsg)
    {
        aslMsg = asl_new(ASL_TYPE_MSG);
        NSString* name = [NSString stringWithFormat:@"%@.%@", [[NSBundle mainBundle] bundleIdentifier], channel.name];
        asl_set(aslMsg, ASL_KEY_FACILITY, [name UTF8String]);
        [self.aslMsgs setObject:[NSValue valueWithPointer:aslMsg] forKey:channel.name];
    }
    
    int level = channel.level ? (int) [channel.level integerValue] : ASL_LEVEL_INFO;
    NSString* output = [self simpleOutputStringForChannel:channel withObject:object arguments:arguments context:context];
    asl_log(self.aslClient, aslMsg, level, "%s", [output UTF8String]);
}

@end
