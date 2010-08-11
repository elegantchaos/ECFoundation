// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@interface ECGLTexture : NSObject 
{
	NSUInteger	texture;  
	NSString	*filename;
}
@property (nonatomic, retain) NSString *filename;
- (id)initWithResourceNamed:(NSString*) name;
- (id)initWithPath:(NSString*) path;
- (id)initWithURL:(NSURL*) url;
- (void)use;
+ (void)useDefaultTexture;
@end
