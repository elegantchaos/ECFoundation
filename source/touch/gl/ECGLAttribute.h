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

ECPropertyDefineRN(name, NSString*);
ECPropertyDefineRN(data, NSData*);
ECPropertyDefineAN(offset, NSUInteger);
ECPropertyDefineAN(count, NSUInteger);
ECPropertyDefineAN(index, GLuint);
ECPropertyDefineAN(size, GLint);
ECPropertyDefineAN(type, GLenum);
ECPropertyDefineAN(normalized, GLboolean);
ECPropertyDefineAN(stride, GLsizei);

@end
