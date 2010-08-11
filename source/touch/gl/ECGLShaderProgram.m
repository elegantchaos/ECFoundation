// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGLShaderProgram.h"
#import "ECGLVertexShader.h"
#import "ECGLFragmentShader.h"

#include <OpenGLES/ES2/gl.h>

@interface ECGLShaderProgram()
- (void) makeProgram;
- (void) disposeProgram;
- (void) releaseShaders;
@end

@implementation ECGLShaderProgram

@synthesize vertexShader;
@synthesize fragmentShader;

- (id) initWithShaderResourcesNamed: (NSString*) name
{
	ECGLVertexShader* vs = [[ECGLVertexShader alloc] init];
	[vs compileFromResourceNamed: name];
	
	ECGLFragmentShader* fs = [[ECGLFragmentShader alloc] init];
	[fs compileFromResourceNamed: name];

	self = [self initWithVertexShader: vs fragmentShader:fs];
	
	[vs release];
	[fs release];
	
	return self;
}

- (id) initWithVertexShader: (ECGLVertexShader*) vs fragmentShader: (ECGLFragmentShader*) fs
{
	if ((self = [super init]) != nil)
	{
		[self makeProgram];
		if (mProgram)
		{
			self.vertexShader = vs;
			self.fragmentShader = fs;
		}
	}
	
	return self;
}

- (void) dealloc
{
	[self releaseShaders];
	[self disposeProgram];
	
	[super dealloc];
}

- (void) releaseShaders
{
	self.vertexShader = nil;
	self.fragmentShader = nil;
}


- (void) makeProgram
{
	if (!mProgram)
	{
		mProgram = glCreateProgram();
	}
}

- (void) disposeProgram
{
	if (mProgram)
	{
		glDeleteProgram(mProgram);
		mProgram = 0;
	}
}

- (void) use
{
	glUseProgram(mProgram);
}

- (int) compileAndLink
{
	int linked = 0;
	
	if ([self.vertexShader isCompiled] && [self.fragmentShader isCompiled])
	{
		if (mProgram)
		{
			glAttachShader(mProgram, [self.vertexShader shader]);
			glAttachShader(mProgram, [self.fragmentShader shader]);
			glLinkProgram(mProgram);
			glGetProgramiv(mProgram, GL_LINK_STATUS, &linked);
			if (linked == 0)
			{
				[self disposeProgram];
			}
		}
	}
	
	return linked;
}

- (int) locationForAttribute: (NSString*) name
{
	
	int location = 0;
	if (mProgram)
	{
		NSRange range = NSMakeRange(0, [name length]);
		GLchar buffer[256];
		NSUInteger size;
		[name getBytes: buffer maxLength: 255 usedLength: &size encoding: NSUTF8StringEncoding options: 0 range: range remainingRange: nil];
		buffer[size] = 0;

		location = glGetAttribLocation(mProgram, buffer);
	}

	return location;
}

- (int) locationForUniform: (NSString*) name
{
	int location = 0;
	if (mProgram)
	{
		NSRange range = NSMakeRange(0, [name length]);
		GLchar buffer[256];
		NSUInteger size;
		[name getBytes: buffer maxLength: 255 usedLength: &size encoding: NSUTF8StringEncoding options: 0 range: range remainingRange: nil];
		buffer[size] = 0;

		location = glGetUniformLocation(mProgram, buffer);
	}
	
	return location;
}

@end
