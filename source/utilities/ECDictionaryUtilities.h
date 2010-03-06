// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 06/03/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

@interface NSDictionary (ECDictionaryUtilities)

- (id) valueForKey: (NSString*) key intoBool: (BOOL*) valueOut;
- (id) valueForKey: (NSString*) key intoDouble: (double*) valueOut;

@end
