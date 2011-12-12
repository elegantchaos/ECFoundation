// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/12/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECModelController.h"

@implementation ECModelController

ECDefineDebugChannel(ModelChannel);

- (void)startup
{
	ECDebug(ModelChannel, @"model startup");
}

- (void)shutdown
{
	ECDebug(ModelChannel, @"model shutdown");
}

@end
