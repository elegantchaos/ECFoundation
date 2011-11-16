// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@interface NSObject(ECLazyProperties)

- (id)setLazyForProperty:(NSString*)property init:(id)init;
+ (void)initializeLazyProperties;

#define lazy_synthesize(name,value) \
class Dummy__; \
- (id)name##Init__ \
{ \
id current = [self name##Init__]; \
return current ? current : [self setLazyForProperty:@#name init:value]; \
}

#define lazy_synthesize_method(name,method) \
class Dummy__; \
- (id)name##Init__ \
{ \
id current = [self name##Init__]; \
return current ? current : [self setLazyForProperty:@#name init:[self method]]; \
}

@end

