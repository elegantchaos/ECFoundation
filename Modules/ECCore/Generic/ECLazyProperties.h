// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 16/11/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@interface NSObject(ECLazyProperties)

+ (void)initializeLazyProperties;

#define lazy_synthesize(name,init) \
synthesize name; \
- (id)name##Init__ \
{ \
id value = [self name##Init__]; \
if (!value) \
{ \
    value = (init); \
    [self setValue:value forKey:@#name]; \
} \
return value; \
}

#define lazy_synthesize_method(name,method) lazy_synthesize(name,[self method])

@end

