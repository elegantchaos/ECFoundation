// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 28/11/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECIsNotEmptyTransformer.h"
#import "ECAssertion.h"

@implementation ECIsNotEmptyTransformer

// --------------------------------------------------------------------------
//! Register transformer.
// --------------------------------------------------------------------------

+ (void)initialize 
{
    ECIsNotEmptyTransformer* transformer = [[[ECIsNotEmptyTransformer alloc] init] autorelease];
    [NSValueTransformer setValueTransformer:transformer forName:@"ECIsNotEmptyTransformer"];
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
	id result = item;
	if (item)
	{
		ECAssert([item respondsToSelector:@selector(length)]);
		
		result = [NSNumber numberWithBool:[(NSString*)item length] != 0];
	}
	
	return result;
}

@end

