//
//  Shader.h
//  Shader
//
//  Created by Sam Deane on 06/08/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECGLShader : NSObject 
{
	NSUInteger	mType;
	NSUInteger	mShader;
	BOOL		mCompiled;
}

@property (readonly, nonatomic) NSUInteger	shader;
@property (readonly, nonatomic) BOOL		isCompiled;

- (id)			initWithType: (NSUInteger) type;
- (int)			compileFromResourceNamed: (NSString*) source;
- (int)			compileFromSource: (NSString*) source;
- (int)			compileFromFile: (NSString*) path;
- (NSString*)	fileType;

@end
