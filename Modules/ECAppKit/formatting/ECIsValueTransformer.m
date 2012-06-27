// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 17/12/2010
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECIsValueTransformer.h"


// ==============================================
// Private Methods
// ==============================================

#pragma mark -
#pragma mark Private Methods

@interface ECIsValueTransformer()

@end


@implementation ECIsValueTransformer

// ==============================================
// Properties
// ==============================================

#pragma mark -
#pragma mark Properties

// ==============================================
// Constants
// ==============================================

#pragma mark -
#pragma mark Constants

// ==============================================
// Lifecycle
// ==============================================

#pragma mark -
#pragma mark Methods

+ (void)initialize 
{
    ECIsValueTransformer *nameTransformer = [[[ECIsValueTransformer alloc] init] autorelease];
    [NSValueTransformer setValueTransformer:nameTransformer forName:@"ECIsValueTransformer"];
}

// --------------------------------------------------------------------------
//! Set up the object.
// --------------------------------------------------------------------------

- (id) init
{
	if ((self = [super init]) != nil)
	{
		
	}
	
	return self;
}

// --------------------------------------------------------------------------
//! Clean up and release retained objects.
// --------------------------------------------------------------------------

- (void) dealloc
{
	[super dealloc];
}

+ (Class)transformedValueClass { return [NSString class]; }
+ (BOOL)allowsReverseTransformation { return NO; }

- (id)transformedValue:(id)item 
{
	BOOL result = [item integerValue] == 3;
	return [NSNumber numberWithBool:result];
}

@end

