// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGLFragmentShader.h"

#include <OpenGLES/ES2/gl.h>

@implementation ECGLFragmentShader

// --------------------------------------------------------------------------
//! Initialise the shader.
// --------------------------------------------------------------------------

- (id) init
{
	if ((self = [super initWithType: GL_FRAGMENT_SHADER]) != nil)
	{
		
	}
	
	return self;
}

// --------------------------------------------------------------------------
//! Return the type of file to load the shader source from.
// --------------------------------------------------------------------------

- (NSString*) fileType
{
	return @"fsh";
}

@end
