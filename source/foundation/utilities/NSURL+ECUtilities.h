// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 17/03/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@interface NSURL(ECUtilities)

+ (NSURL*) URLWithResourceNamed: (NSString*) name ofType: (NSString*) type;
- (id) initWithResourceNamed: (NSString*) name ofType: (NSString*) type;

@end
