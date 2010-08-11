// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

#import "ECGLCommon.h"

@class ECGLShaderProgram;
@class ECGLTexture;
@class ECGLAttribute;

// --------------------------------------------------------------------------
//! A collection of geometry which can be drawn.
// --------------------------------------------------------------------------

@interface ECGLMesh : NSObject 
{
	Matrix3D		mTransform;
	GLint			mMVP;
}

// --------------------------------------------------------------------------
// Public Properties.
// --------------------------------------------------------------------------

@property (assign, nonatomic) Vertex3D				position;
@property (assign, nonatomic) Vertex3D				orientation;
@property (assign, nonatomic) NSUInteger			count;
@property (retain, nonatomic) NSMutableArray*		attributes;
@property (retain, nonatomic) NSMutableArray*		textures;
@property (retain, nonatomic) ECGLShaderProgram*	shaders;
@property (assign, nonatomic) BOOL					cullFace;
@property (assign, nonatomic) BOOL					wireFrame;

// --------------------------------------------------------------------------
// Public Methods.
// --------------------------------------------------------------------------

- (void)		updateTransform;
- (GLfloat*)	transform;
- (void)		resolveIndexes;
- (void)		use;
- (void)		draw: (GLfloat*) mvp;
- (void)		addTexture: (ECGLTexture*) texture;
- (void)		addAttribute: (ECGLAttribute*) attribute;

@end
