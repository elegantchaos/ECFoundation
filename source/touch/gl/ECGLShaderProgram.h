//
//  ShaderProgram.h
//  ogl-test
//
//  Created by Sam Deane on 06/08/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ECGLVertexShader;
@class ECGLFragmentShader;

@interface ECGLShaderProgram : NSObject 
{
	NSInteger mProgram;
}

@property (retain, nonatomic) ECGLVertexShader* vertexShader;
@property (retain, nonatomic) ECGLFragmentShader* fragmentShader;

- (id) initWithShaderResourcesNamed: (NSString*) name;
- (id) initWithVertexShader: (ECGLVertexShader*) vertexShader fragmentShader: (ECGLFragmentShader*) fragmentShader;
- (int) compileAndLink;
- (void) use;

- (int) locationForAttribute: (NSString*) name;
- (int) locationForUniform: (NSString*) name;
@end
