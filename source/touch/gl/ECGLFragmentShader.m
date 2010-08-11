//
//  FragmentShader.m
//  Shader
//
//  Created by Sam Deane on 06/08/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//

#import "ECGLFragmentShader.h"

#include <OpenGLES/ES2/gl.h>

@implementation ECGLFragmentShader

- (id) init
{
	if ((self = [super initWithType: GL_FRAGMENT_SHADER]) != nil)
	{
		
	}
	
	return self;
}

- (NSString*) fileType
{
	return @"fsh";
}

@end
