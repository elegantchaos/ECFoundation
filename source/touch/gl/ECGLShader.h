// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@interface ECGLShader : NSObject 
{
	NSUInteger	mType;
	NSUInteger	mShader;
	BOOL		mCompiled;
}

@property (readonly, nonatomic) NSUInteger	shader;
@property (readonly, nonatomic) BOOL		isCompiled;

- (id)			initWithType: (NSUInteger) type;
- (int)			compileFromResourceNamed: (NSString*) source;
- (int)			compileFromSource: (NSString*) source;
- (int)			compileFromPath: (NSString*) path;
- (int)			compileFromURL: (NSURL*) url;
- (NSString*)	fileType;

@end
