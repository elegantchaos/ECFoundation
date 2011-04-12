// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//! @file:
//! Property utilities.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

// --------------------------------------------------------------------------
//! Define the instance variable that will back a property.
// --------------------------------------------------------------------------

#define ECPropertyVariable(name, type)		type _##name

// --------------------------------------------------------------------------
//! Define a property.
// --------------------------------------------------------------------------

#define ECPropertyDefine(name, type, ...)		@property (__VA_ARGS__) type name

// some convenient abbreviatations for common cases
#define ECPropertyRetained(name, type)			ECPropertyDefine(name, type, retain, nonatomic)
#define ECPropertyAssigned(name, type)			ECPropertyDefine(name, type, assign, nonatomic)
#define ECPropertyCopy(name, type)				ECPropertyDefine(name, type, copy, nonatomic)

// --------------------------------------------------------------------------
//! Define a lazy property.
// --------------------------------------------------------------------------

#define ECPropertyDefineLazy(name, type, ...)		\
@property (__VA_ARGS__) type name##Lazy; \
@property (__VA_ARGS__) type name; \
- (type) name##LazyInit

#define ECPropertyDefineLazyRN(name, type)		ECPropertyDefineLazy(name, type, retain, nonatomic)
#define ECPropertyDefineLazyAN(name, type)		ECPropertyDefineLazy(name, type, assign, nonatomic)
#define ECPropertyDefineLazyCN(name, type)		ECPropertyDefineLazy(name, type, copy, nonatomic)

// --------------------------------------------------------------------------
//! Synthesize a property.
// --------------------------------------------------------------------------

#define ECPropertySynthesize(name)				@synthesize name = _##name

// --------------------------------------------------------------------------
//! Synthesize a lazy property.
// --------------------------------------------------------------------------

#define ECPropertySynthesizeLazy(name, setter, type)	\
@synthesize name##Lazy = _##name; \
- (type) name { if (!_##name) self.name##Lazy = [self name##LazyInit]; return self.name##Lazy; } \
- (void) setter: (type) value { self.name##Lazy = value; }


// --------------------------------------------------------------------------
//! Return the raw instance variable backing a property.
// --------------------------------------------------------------------------

#define ECPropertyInstance(name)				_##name

// --------------------------------------------------------------------------
//! Release a property in a way that's safe to use in dealloc.
// --------------------------------------------------------------------------

#define ECPropertyDealloc(name)					[_##name release]

// --------------------------------------------------------------------------
//! Initialise a property, in a way that's safe to use in init.
//! We bypass any setter function, and therefore won't do any special 
//! processing such as retaining/copying the value.
// --------------------------------------------------------------------------

#define ECPropertyInit(name, value)				_##name = value

