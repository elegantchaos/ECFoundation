// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

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
