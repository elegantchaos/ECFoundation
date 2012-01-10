// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/12/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECLogging.h"

ECDeclareDebugChannel(ModelChannel);

@interface ECModelController : NSObject

+ (ECModelController*)sharedInstance;

- (void)startup;
- (void)shutdown;
- (void)load;
- (void)save;

@end
