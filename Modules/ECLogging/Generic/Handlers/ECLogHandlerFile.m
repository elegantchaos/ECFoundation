// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECLogHandlerFile.h"
#import "ECLogChannel.h"

#include <stdio.h>

@implementation ECLogHandlerFile

#pragma mark - Lifecycle

// --------------------------------------------------------------------------
//! Initialise.
// --------------------------------------------------------------------------

- (id) init 
{
    if ((self = [super init]) != nil) 
    {
        self.name = @"File";
    }
    
    return self;
}


#pragma mark - Logging

- (void) logFromChannel: (ECLogChannel*) channel withFormat: (NSString*) format arguments: (va_list) arguments context:(ECLogContext *)context
{
    NSString* output;
    if (![channel showContext:ECLogContextMessage])
    {
        // just log the context
        output = [channel stringFromContext:context];
    }
    else
    {
        // log the message, possibly with a context appended
        output = [[[NSString alloc] initWithFormat: format arguments: arguments] autorelease];
        NSString* contextString = [channel stringFromContext:context];
        if ([contextString length])
        {
            output = [NSString stringWithFormat:@"%@ «%@»", output, contextString];
        }
    }
    
    NSData* data = [output dataUsingEncoding:NSUTF8StringEncoding];

    NSError* error = nil;
    NSFileManager* fm = [NSFileManager defaultManager];
    NSURL* libraryFolder = [fm URLForDirectory:NSLibraryDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:&error];
    NSURL* logsFolder = [libraryFolder URLByAppendingPathComponent:@"Logs"];
    NSURL* logFolder = [logsFolder URLByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]];
    [fm createDirectoryAtURL:logFolder withIntermediateDirectories:YES attributes:nil error:&error];
    NSURL* logFile = [logFolder URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.log", channel.name]];
    if ([fm fileExistsAtPath:[logFile path]])
    {
        NSFileHandle* file = [NSFileHandle fileHandleForWritingToURL:logFile error:&error];
        if (file)
        {
            [file writeData:data];
            [file closeFile];
        }
    }
    else
    {
        [fm createFileAtPath:[logFile path] contents:data attributes:nil];
    }
}

@end
