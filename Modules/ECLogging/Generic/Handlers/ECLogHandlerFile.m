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

@interface ECLogHandlerFile()

@property (nonatomic, retain) NSMutableDictionary* files;
@property (nonatomic, retain) NSURL* logFolder;

@end

@implementation ECLogHandlerFile

@synthesize files;
@synthesize logFolder;

#pragma mark - Lifecycle

// --------------------------------------------------------------------------
//! Initialise.
// --------------------------------------------------------------------------

- (id) init 
{
    if ((self = [super init]) != nil) 
    {
        self.name = @"File";
        
        NSError* error = nil;
        NSFileManager* fm = [NSFileManager defaultManager];
        NSURL* libraryFolder = [fm URLForDirectory:NSLibraryDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:&error];
        NSURL* logsFolder = [libraryFolder URLByAppendingPathComponent:@"Logs"];
        self.logFolder = [logsFolder URLByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]];
        [fm removeItemAtURL:self.logFolder error:&error];
        [fm createDirectoryAtURL:self.logFolder withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    return self;
}

- (void)dealloc
{
    [files release];
    [logFolder release];
    
    [super dealloc];
}

#pragma mark - Logging

- (NSURL*)logFileForChannel:(ECLogChannel*)channel
{
    NSMutableDictionary* fileCache = self.files;
    if (fileCache == nil)
    {
        fileCache = [NSMutableDictionary dictionary];
        self.files = fileCache;
    }
    
    NSURL* logFile = [fileCache objectForKey:channel.name];
    if (!logFile)
    {
        logFile = [self.logFolder URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.log", channel.name]];
        [fileCache setObject:logFile forKey:channel.name];
    }

    return logFile;
}

- (void)logString:(NSString*)string forChannel:(ECLogChannel*)channel
{
    NSData* data = [[string stringByAppendingString:@"\n"] dataUsingEncoding:NSUTF8StringEncoding];
    NSFileManager* fm = [NSFileManager defaultManager];
    NSURL* logFile = [self logFileForChannel:channel];
    if ([fm fileExistsAtPath:[logFile path]])
    {
        NSError* error = nil;
        NSFileHandle* file = [NSFileHandle fileHandleForWritingToURL:logFile error:&error];
        if (file)
        {
            [file seekToEndOfFile];
            [file writeData:data];
            [file closeFile];
        }
    }
    else
    {
        [fm createFileAtPath:[logFile path] contents:data attributes:nil];
    }
   
}

- (void) logFromChannel:(ECLogChannel*)channel withFormat:(NSString*)format arguments:(va_list)arguments context:(ECLogContext *)context
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
    
    [self logString:output forChannel:channel];
}

@end
