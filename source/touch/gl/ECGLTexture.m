// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGLTexture.h"

#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@implementation ECGLTexture
@synthesize filename;

- (id) initWithResourceNamed: (NSString*) name
{
	NSString* extension = [name pathExtension];
	NSString* baseFilenameWithExtension = [name lastPathComponent];
	NSString* baseFilename = [baseFilenameWithExtension substringToIndex:[baseFilenameWithExtension length] - [extension length] - 1];
	
	NSString* path = [[NSBundle mainBundle] pathForResource:baseFilename ofType:extension];
	return [self initWithPath: path];
}

- (id)initWithURL:(NSURL*) url
{
	return [self initWithPath: [url path]];
}

- (id) initWithPath: (NSString*) path
{
	if ((self = [super init]))
	{
		glEnable(GL_TEXTURE_2D);
		glEnable(GL_BLEND);
        
		self.filename = path;
		glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);  
		glGenTextures(1, &texture);
		glBindTexture(GL_TEXTURE_2D, texture);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR); 
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR); 
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
		
		NSData *texData = [[NSData alloc] initWithContentsOfFile: path];
		
		
        
        UIImage *image = [[UIImage alloc] initWithData:texData];
		[texData release];
        if (image == nil)
            return nil;
        
        GLuint width = CGImageGetWidth(image.CGImage);
        GLuint height = CGImageGetHeight(image.CGImage);
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        void *imageData = malloc( height * width * 4 );
        CGContextRef context = CGBitmapContextCreate( imageData, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big );
        CGContextTranslateCTM (context, 0, height);
        CGContextScaleCTM (context, 1.0, -1.0);
        CGColorSpaceRelease( colorSpace );
        CGContextClearRect( context, CGRectMake( 0, 0, width, height ) );
        CGContextDrawImage( context, CGRectMake( 0, 0, width, height ), image.CGImage );
        
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, imageData);
        CGContextRelease(context);
        
        free(imageData);
        [image release];
		
        
	}
	return self;
}
+ (void)useDefaultTexture
{
	glBindTexture(GL_TEXTURE_2D, 0);
}
- (void)use
{
	glBindTexture(GL_TEXTURE_2D, texture);
}
- (void)dealloc
{
	glDeleteTextures(1, &texture);
	[filename release];
	[super dealloc];
}
@end
