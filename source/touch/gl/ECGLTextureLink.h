//
//  GLTextureLink.h
//  ogl-test
//
//  Created by Sam Deane on 09/08/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ECGLTexture;
@interface ECGLTextureLink : NSObject 
{

}

@property (retain, nonatomic) ECGLTexture*	texture;
@property (assign, nonatomic) NSInteger		index;

@end
