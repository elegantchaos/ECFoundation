// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 17/03/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "NSURL+ECCore.h"

@interface NSURL(ECCoreMac)

- (BOOL)asFSRef:(FSRef*)ref;
+ (NSURL*)URLWithFSRef:(FSRef*)ref;

@end
