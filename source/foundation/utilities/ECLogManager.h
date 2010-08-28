// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 26/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@class ECLogChannel;

@interface ECLogManager : NSObject
{
	ECPropertyVariable(channels, NSMutableArray*);
}

ECPropertyRetained(channels, NSMutableArray*);

+ (ECLogManager*) sharedInstance;

- (void) registerChannel: (ECLogChannel*) channel;

@end

// --------------------------------------------------------------------------
// Notifications
// --------------------------------------------------------------------------

extern NSString *const LogChannelsChanged;
