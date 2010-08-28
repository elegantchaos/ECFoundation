// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 26/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@class ECLogChannel;

// --------------------------------------------------------------------------
//! Manager which keeps track of all the log channels.
// --------------------------------------------------------------------------

@interface ECLogManager : NSObject
{
	ECPropertyVariable(channels, NSMutableArray*);
}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

ECPropertyRetained(channels, NSMutableArray*);

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

+ (ECLogManager*) sharedInstance;

- (void) registerChannel: (ECLogChannel*) channel;
- (void) shutdown;

@end

// --------------------------------------------------------------------------
// Notifications
// --------------------------------------------------------------------------

extern NSString *const LogChannelsChanged;
