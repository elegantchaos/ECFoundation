// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

#define ECLazyInterface(class, base) \
    @interface class##_nonlazy : base \
    @end \
    @interface class : class##_nonlazy \
    @end \
    @interface class##_nonlazy(LazyProperties)


#define ECLazyImplementation(class) \
    implementation class##_nonlazy(LazyProperties)

#define ECLazyProperty(name) \
    { \
        id value = [super name]; \
        if (!value) \
        { \
            value = [super init##name]; \
            self.name = value; \
        } \
        return value; \
    }

    @interface 

#define lazy_interface ECLazyInterface
#define lazy_implementation ECLazyImplementation