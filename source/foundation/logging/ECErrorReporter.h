// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@class ECLogChannel;
@class ECLogHandler;

// --------------------------------------------------------------------------
//! Manager which keeps track of all the log channels.
// --------------------------------------------------------------------------

@interface ECErrorReporter : NSObject
{
}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------


// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

+ (BOOL)checkStatus:(OSStatus)status;

+ (void)reportResult:(BOOL)didSucceed error:(NSError*) error message:(NSString*)message, ... NS_FORMAT_FUNCTION(3,4);
+ (void)reportResult:(BOOL)didSucceed message:(NSString*)message, ... NS_FORMAT_FUNCTION(2,3);
+ (void)reportStatus:(OSStatus)status message:(NSString*)message, ... NS_FORMAT_FUNCTION(2,3);
+ (void)reportError:(NSError*) error message:(NSString*)message, ... NS_FORMAT_FUNCTION(2,3);

@end
