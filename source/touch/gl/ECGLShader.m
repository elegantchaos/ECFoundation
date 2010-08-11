// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGLShader.h"

#include <OpenGLES/ES2/gl.h>

@interface ECGLShader()
- (void) makeShader;
- (void) disposeShader;
- (void) logError;
@end

@implementation ECGLShader

@synthesize shader = mShader;

- (id) initWithType: (NSUInteger) type
{
	if ((self = [super init]) != nil)
	{
		mType = type;
		[self makeShader];
	}
	
	return self;
}

- (void) makeShader
{
	if (!mShader)
	{
		mShader = glCreateShader(mType);
	}
}

- (void) disposeShader
{
	if (mShader)
	{
		glDeleteShader(mShader);
		mShader = 0;
	}
}

- (void) dealloc
{
	[self disposeShader];
	[super dealloc];
}

- (int) compileFromResourceNamed: (NSString*) name
{
	int success = 0;
	NSString* path = [[NSBundle mainBundle] pathForResource: name ofType: [self fileType]];
	if (path)
	{
		success = [self compileFromPath: path];
	}
	else
	{
		NSLog(@"Shader resource '%@' missing.", name);
	}
	
	return success;
}

- (int) compileFromURL: (NSURL*) url
{
	return [self compileFromPath: [url path]];
}

- (int) compileFromPath: (NSString*) path
{
	NSError* error = nil;
	NSString* source = [NSString stringWithContentsOfFile: path encoding: NSUTF8StringEncoding error: &error];
	
	int success = 0;
	if (source)
	{
		success = [self compileFromSource: source];
	}
	else if (error)
	{
		NSLog(@"Error loading shader from '%@':\n", error);
	}
		
	return success;
}

- (int) compileFromSource: (NSString*) source
{
	int success = 0;
	if (mShader)
	{
		NSUInteger size;
		NSRange range = NSMakeRange(0, [source length]);
		[source getBytes: nil maxLength: 0 usedLength: &size encoding: NSUTF8StringEncoding options: 0 range: range remainingRange: nil];
		GLchar* buffer = malloc(size + 1);
		[source getBytes: buffer maxLength: size usedLength: &size encoding: NSUTF8StringEncoding options: 0 range: range remainingRange: nil];
		buffer[size] = 0;
		
		glShaderSource(mShader, 1, (const GLchar**) &buffer, NULL);
		glCompileShader(mShader);
		
		free(buffer);
		
		glGetShaderiv(mShader, GL_COMPILE_STATUS, &success);
		if (success == 0)
		{
			[self logError];
			[self disposeShader];
		}
	}
	
	return success;
}

- (void) logError
{
	if (mShader)
	{
		char errorMsg[2048];
		glGetShaderInfoLog(mShader, sizeof(errorMsg), NULL, errorMsg);
		NSLog(@"Shader error: %s", errorMsg); 
	}
}

- (BOOL) isCompiled
{
	BOOL result = NO;
	if (mShader)
	{
		int success = 0;
		glGetShaderiv(mShader, GL_COMPILE_STATUS, &success);
		result = (success != 0);
	}
	
	return result;
}

- (NSString*) fileType
{
	return @"txt";
}

@end
