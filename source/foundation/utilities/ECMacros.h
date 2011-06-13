// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//! @file:
//! Miscellaneous macros.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#define ECUnused(v)	(void) (v)

#define EC_HINT_UNUSED __attribute__((__unused__))

#define EC_EXPORTED __attribute__((visibility("default"))) 

#ifdef EC_DEBUG
#define ECDebugOnly(x) x
#define ECReleaseOnly(x)
#else
#define ECDebugOnly(x)
#define ECReleaseOnly(x) x
#endif
