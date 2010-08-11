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

@property (retain, nonatomic) NSString*		name;
@property (assign, nonatomic) const void*	data;
@property (assign, nonatomic) NSUInteger	count;
@property (assign, nonatomic) GLint			index;
@property (assign, nonatomic) int			size;
@property (assign, nonatomic) int			type;
@property (assign, nonatomic) BOOL			normalized;
@property (assign, nonatomic) int			stride;

@end
