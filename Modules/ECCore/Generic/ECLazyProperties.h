// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

#define lazy_interface(class,parent) interface class##_nonlazy : parent
#define end_lazy_interface(class) end @interface class : class##_nonlazy @end

#define lazy_implementation(class) implementation class##_nonlazy
#define lazy_properties(class) end @implementation class
#define end_lazy_implementation(class) end

#define lazy_synthesize(prop) \
    class Dummy__; \
    - (NSString*)prop \
    { \
    id value = [super prop]; \
    if (!value) \
    { \
    value = [super prop##Init]; \
    self.test = value; \
    } \
    \
    return value; \
    }
