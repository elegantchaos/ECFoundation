// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 22/07/2010
//
//! @file:
//! Assertion utilities.
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#define ECAssertShouldntBeHereBase(imp) imp(FALSE)
#define ECAssertNonNilBase(expression, imp) imp((expression) != nil)
#define ECAssertCountAtLeastBase(container, countMinimum, imp) imp([container count] >= countMinimum)

#define ECAssert(expression) NSAssert((expression), @" expression" #expression " was false")
#define ECAssertC(expression) assert(expression)

#define ECAssertShouldntBeHere() ECAssertShouldntBeHereBase(ECAssert)
#define ECAssertShouldntBeHereC() ECAssertShouldntBeHereBase(ECAssertC)

#define ECAssertNonNil(expression) ECAssertNonNilBase(expression, ECAssert)
#define ECAssertCountAtLeast(container, countMinimum) ECAssertCountAtLeastBase(container, countMinimum, ECAssert)

#define ECAssertNonNilC(expression) ECAssertNonNilBase(expression, ECAssertC)
#define ECAssertCountAtLeastC(container, countMinimum) ECAssertCountAtLeastBase(container, countMinimum, ECAssertC)
