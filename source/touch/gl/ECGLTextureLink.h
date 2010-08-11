// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@class ECGLTexture;
@interface ECGLTextureLink : NSObject 
{

}

@property (retain, nonatomic) ECGLTexture*	texture;
@property (assign, nonatomic) NSInteger		index;

@end
