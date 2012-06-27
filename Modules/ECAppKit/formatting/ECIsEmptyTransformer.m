// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 28/11/2011
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECIsEmptyTransformer.h"
#import "ECAssertion.h"

@implementation ECIsEmptyTransformer

// --------------------------------------------------------------------------
//! Register transformer.
// --------------------------------------------------------------------------

+ (void)initialize 
{
    ECIsEmptyTransformer* transformer = [[[ECIsEmptyTransformer alloc] init] autorelease];
    [NSValueTransformer setValueTransformer:transformer forName:@"ECIsEmptyTransformer"];
}

// --------------------------------------------------------------------------
//1 We return a boolean as an NSNumber
// --------------------------------------------------------------------------

+ (Class)transformedValueClass 
{
	return [NSNumber class]; 
}

// --------------------------------------------------------------------------
//! Don't allow reverse transformation.
// --------------------------------------------------------------------------

+ (BOOL)allowsReverseTransformation 
{
	return NO; 
}

// --------------------------------------------------------------------------
//! Perform the transformation.
// --------------------------------------------------------------------------

- (id)transformedValue:(id)item 
{
	ECAssert([item respondsToSelector:@selector(length)]);

	NSString* string = item;
	BOOL result = [string length] == 0;
	return [NSNumber numberWithBool:result];
}

@end

