// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGLMesh.h"
#import "ECGLCommon.h"
#import "ECGLAttribute.h"
#import "ECGLShaderProgram.h"
#import "ECGLTexture.h"
#import "ECGLTextureLink.h"

@implementation ECGLMesh

@synthesize position;
@synthesize attributes;
@synthesize shaders;
@synthesize count;
@synthesize textures;
@synthesize orientation;
@synthesize cullFace;
@synthesize wireFrame;

- (id) init
{
	if ((self = [super init]) != nil)
	{
		NSMutableArray* atts = [[NSMutableArray alloc] init];
		self.attributes = atts;
		[atts release];
		
		NSMutableArray* tex = [[NSMutableArray alloc] init];
		self.textures = tex;
		[tex release];
		
		self.cullFace = YES;
	}
	
	return self;
}

- (void) dealloc
{
	self.attributes = nil;
	self.shaders = nil;
	self.textures = nil;
	
	[super dealloc];
}

- (void) addTexture:(ECGLTexture *)texture
{
	ECGLTextureLink* link = [[ECGLTextureLink alloc] init];
	link.texture = texture;
	[self.textures addObject: link];
	[link release];
}

- (void) updateTransform
{
	
    static const Vector3D rotateX = {1.f, 0.f, 0.f};
    static const Vector3D rotateY = {0.f, 1.f, 0.f};
    static const Vector3D rotateZ = {0.f, 0.f, 1.f};

	Matrix3D rotationXMatrix;
    Matrix3DSetRotationByDegrees(rotationXMatrix, orientation.x, rotateX);

	Matrix3D rotationYMatrix;
    Matrix3DSetRotationByDegrees(rotationYMatrix, orientation.y, rotateY);

	Matrix3D rotationZMatrix;
    Matrix3DSetRotationByDegrees(rotationZMatrix, orientation.z, rotateZ);

	Matrix3D translationMatrix;
	Vertex3D pos = self.position;
	Matrix3DSetTranslation(translationMatrix, -pos.x, -pos.y, -pos.z);
	
	Matrix3D temp;
	Matrix3DMultiply(rotationXMatrix, rotationYMatrix, mTransform);
	Matrix3DMultiply(rotationZMatrix, mTransform, temp);
	Matrix3DMultiply(translationMatrix, temp, mTransform);
}

- (GLfloat*) transform
{
	return mTransform;
}

- (void) addAttribute:(ECGLAttribute *)attribute
{
	[self.attributes addObject: attribute];
}

- (void) resolveIndexes
{
	mMVP = [self.shaders locationForUniform: @"matrix"];

	for (ECGLAttribute* attribute in self.attributes)
	{
		attribute.index = [self.shaders locationForAttribute: attribute.name];
	}
	
	NSUInteger textureNumber = 0;
	for (ECGLTextureLink* texture in self.textures)
	{
		texture.index = [self.shaders locationForUniform: [NSString stringWithFormat: @"texture%d", textureNumber++]];
	}

}

- (void) use
{
	[self.shaders use];
	
	for (ECGLAttribute* attribute in self.attributes)
	{
		glVertexAttribPointer(attribute.index, attribute.size, attribute.type, attribute.normalized, attribute.stride, [attribute.data bytes]);
		glEnableVertexAttribArray(attribute.index);
	}
	
	NSInteger textureIndex = 0;
	NSUInteger textureCount = [self.textures count];
	if (textureCount)
	{
		glEnable(GL_TEXTURE_2D);
		for (ECGLTextureLink* texture in self.textures)
		{
			glActiveTexture(GL_TEXTURE0 + textureIndex++);
			[texture.texture use];
			glUniform1f(texture.index, 0);		
		}
		for (; textureIndex < 4; ++textureIndex)
		{
			glActiveTexture(GL_TEXTURE0 + textureIndex);
			glBindTexture(GL_TEXTURE_2D, 0);
		}
	}
	else
	{
		glDisable(GL_TEXTURE_2D);
	}
	
	if (self.cullFace)
	{	
		glEnable(GL_CULL_FACE);
	}
	else
	{
		glDisable(GL_CULL_FACE);
	}
}

- (void) draw: (GLfloat*) mvp
{
	glUniformMatrix4fv(mMVP, 1, GL_FALSE, mvp);
	
	if (self.wireFrame)
	{
		for(NSUInteger i = 0; i < self.count; i += 3)
			glDrawArrays(GL_LINE_LOOP, i, 3);
	}
	else
	{
		glDrawArrays(GL_TRIANGLES, 0, self.count);
	}
	

}

@end
