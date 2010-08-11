//
//  VertexShader.m
//  Shader
//
//  Created by Sam Deane on 06/08/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//

#import "ECGLVertexShader.h"

#include <OpenGLES/ES2/gl.h>


@implementation ECGLVertexShader

- (id) init
{
	if ((self = [super initWithType: GL_VERTEX_SHADER]) != nil)
	{
		
	}
	
	return self;
}

- (NSString*) fileType
{
	return @"vsh";
}

@end
