// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 13/03/2011
//
//! @file Keychain utilities
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@interface ECKeychain : NSObject

+ (NSData*) appleRootCertificate;

@end
