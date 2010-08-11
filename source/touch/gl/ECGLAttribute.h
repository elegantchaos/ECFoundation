//
//  GLAttribute.h
//  ogl-test
//
//  Created by Sam Deane on 09/08/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ECGLAttribute : NSObject 
{
}

@property (retain, nonatomic) NSString*		name;
@property (assign, nonatomic) const void*	data;
@property (assign, nonatomic) NSUInteger	count;
@property (assign, nonatomic) int			index;
@property (assign, nonatomic) int			size;
@property (assign, nonatomic) int			type;
@property (assign, nonatomic) BOOL			normalized;
@property (assign, nonatomic) int			stride;

@end
