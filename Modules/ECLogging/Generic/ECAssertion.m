// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#include "ECAssertion.h"

ECDefineDebugChannel(AssertionChannel);

@implementation ECAssertion

+ (void)failAssertion:(const char*)expression
{
    [NSException raise:@"ECAssertion failed" format:@"Expression:%s", expression, nil];
}

@end