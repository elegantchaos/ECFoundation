// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGLCommon.h"

// --------------------------------------------------------------------------
//! A high level abstraction of some 3d attributes - for example
//! an array of vertices or texture coordinates.
// --------------------------------------------------------------------------

@interface ECGLAttribute : NSObject 
{
}

// --------------------------------------------------------------------------
// Public Properties.
// --------------------------------------------------------------------------

ECPropertyRetained(name, NSString*);
ECPropertyRetained(data, NSData*);
ECPropertyAssigned(offset, NSUInteger);
ECPropertyAssigned(count, NSUInteger);
ECPropertyAssigned(index, GLuint);
ECPropertyAssigned(size, GLint);
ECPropertyAssigned(type, GLenum);
ECPropertyAssigned(normalized, GLboolean);
ECPropertyAssigned(stride, GLsizei);

@end
