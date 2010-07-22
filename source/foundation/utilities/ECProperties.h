// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 22/07/2010
//
//! @file:
//! Property utilities.
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

// --------------------------------------------------------------------------
//! Define the member variable that will back a property.
// --------------------------------------------------------------------------

#define ECPropertyDefineMember(name, type)		type _##name

// --------------------------------------------------------------------------
//! Define a property.
// --------------------------------------------------------------------------

#define ECPropertyDefine(name, type, ...)		@property (__VA_ARGS__) type name

// --------------------------------------------------------------------------
//! Synthesize a property.
// --------------------------------------------------------------------------

#define ECPropertySynthesize(name)				@synthesize name = _##name

// --------------------------------------------------------------------------
//! Return the raw member backing a property.
// --------------------------------------------------------------------------

#define ECPropertyMember(name)					_##name

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

