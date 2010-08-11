// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGLVertexShader.h"

#include <OpenGLES/ES2/gl.h>


@implementation ECGLVertexShader

// --------------------------------------------------------------------------
//! Initialise the shader.
// --------------------------------------------------------------------------

- (id) init
{
	if ((self = [super initWithType: GL_VERTEX_SHADER]) != nil)
	{
		
	}
	
	return self;
}

// --------------------------------------------------------------------------
//! Return the type of file to load the shader from.
// --------------------------------------------------------------------------

- (NSString*) fileType
{
	return @"vsh";
}

@end
