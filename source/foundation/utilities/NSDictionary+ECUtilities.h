// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 06/03/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@interface NSDictionary (ECUtilities)

- (id) valueForKey: (NSString*) key intoBool: (BOOL*) valueOut;
- (id) valueForKey: (NSString*) key intoDouble: (double*) valueOut;

@end
