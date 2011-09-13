// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "UIImage+ECUtilities.h"

@interface UIImage ()
- (UIImage *)resizedImage:(CGSize)newSize transform:(CGAffineTransform)transform drawTransposed:(BOOL)transpose interpolationQuality:(CGInterpolationQuality)quality;
- (CGAffineTransform)transformForOrientation:(CGSize)newSize;
@end


@implementation UIImage (util)

// Returns a copy of this image that is cropped to the given bounds
// Note that the bounds will be adjusted using CGRectIntegral
- (UIImage*)imageByCroppingToRect:(CGRect)bounds
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], bounds);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return croppedImage;
}



// Returns a copy of this image that is squared to the thumbnail size.
// If transparentBorder is non-zero, a transparent border of the given size will be added around the edges of the thumbnail. (Adding a transparent border of at least one pixel in size has the side-effect of antialiasing the edges of the image when rotating it using Core Animation.)
- (UIImage*)imageAsThumbnail:(NSInteger)thumbnailSize interpolationQuality:(CGInterpolationQuality)quality
{
    UIImage *resizedImage = [self imageByResizingWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(thumbnailSize, thumbnailSize) interpolationQuality:quality];
    
    CGRect cropRect = CGRectMake(roundf((resizedImage.size.width - thumbnailSize) / 2),
                                 roundf((resizedImage.size.height - thumbnailSize) / 2),
                                 (CGFloat) thumbnailSize,
                                 (CGFloat) thumbnailSize);

    return [resizedImage imageByCroppingToRect:cropRect];
}


 
- (UIImage*)imageByresizingToFit:(CGSize)targetSize interpolationQuality:(CGInterpolationQuality)quality
{
	
	CGFloat scaleFactor = 0.0f;
	CGFloat scaledWidth;
	CGFloat scaledHeight;
	
	CGFloat widthFactor = targetSize.width / self.size.width;
	CGFloat heightFactor = targetSize.height / self.size.height;
	
	if (widthFactor < heightFactor) {
		scaleFactor = widthFactor; // scale to fit height
	} else {
		scaleFactor = heightFactor; // scale to fit width
	}
	
	scaledWidth  = self.size.width * scaleFactor;
	scaledHeight = self.size.height * scaleFactor;
	
    return [self imageByResizingWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(scaledWidth, scaledHeight) interpolationQuality:quality];
}

// Returns a rescaled copy of the image, taking into account its orientation
// The image will be scaled disproportionately if necessary to fit the bounds specified by the parameter

- (UIImage*)imageByResizingTo:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality
{
    BOOL drawTransposed;
    
    switch (self.imageOrientation)
	{
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            drawTransposed = YES;
            break;
            
        default:
            drawTransposed = NO;
    }
    
    return [self resizedImage:newSize transform:[self transformForOrientation:newSize] drawTransposed:drawTransposed interpolationQuality:quality];
}

// Resizes the image according to the given content mode, taking into account the image's orientation

- (UIImage*)imageByResizingWithContentMode:(UIViewContentMode)contentMode bounds:(CGSize)bounds interpolationQuality:(CGInterpolationQuality)quality
{
    CGFloat horizontalRatio = bounds.width / self.size.width;
    CGFloat verticalRatio = bounds.height / self.size.height;
    CGFloat ratio=0.0f;
    
    switch (contentMode) {
        case UIViewContentModeScaleAspectFill:
            ratio = MAX(horizontalRatio, verticalRatio);
            break;
            
        case UIViewContentModeScaleAspectFit:
            ratio = MIN(horizontalRatio, verticalRatio);
            break;
            
        default:
            [NSException raise:NSInvalidArgumentException format:@"Unsupported content mode: %d", contentMode];
    }
    
    CGSize newSize = CGSizeMake(self.size.width * ratio, self.size.height * ratio);
    
    return [self imageByResizingTo:newSize interpolationQuality:quality];
}

#pragma mark -
#pragma mark Private helper methods

// Returns a copy of the image that has been transformed using the given affine transform and scaled to the new size
// The new image's orientation will be UIImageOrientationUp, regardless of the current image's orientation
// If the new size is not integral, it will be rounded up
- (UIImage *)resizedImage:(CGSize)newSize transform:(CGAffineTransform)transform drawTransposed:(BOOL)transpose interpolationQuality:(CGInterpolationQuality)quality
{
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGRect transposedRect = CGRectMake(0, 0, newRect.size.height, newRect.size.width);
    CGImageRef imageRef = self.CGImage;
    
	size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
	CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
	
	// always use a supported bitmap format, regardless of the format of the input image
	CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedLast;
	
    // Build a context that's the same dimensions as the new size
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                bitsPerComponent,
                                                0,
                                                colorSpace,
                                                bitmapInfo);
    
    // Rotate and/or flip the image if required by its orientation
    CGContextConcatCTM(bitmap, transform);
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(bitmap, quality);
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    
    return newImage;
}

// Returns an affine transform that takes into account the image orientation when drawing a scaled image
- (CGAffineTransform)transformForOrientation:(CGSize)newSize {
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:           // EXIF = 3
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
            transform = CGAffineTransformRotate(transform, (CGFloat) M_PI);
            break;
            
        case UIImageOrientationLeft:           // EXIF = 6
        case UIImageOrientationLeftMirrored:   // EXIF = 5
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformRotate(transform, (CGFloat) M_PI_2);
            break;
            
        case UIImageOrientationRight:          // EXIF = 8
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, 0, newSize.height);
            transform = CGAffineTransformRotate(transform, (CGFloat) -M_PI_2);
            break;
			
		default:
			break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:     // EXIF = 2
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:   // EXIF = 5
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, newSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
			
		default:
			break;
    }
    
    return transform;
}

- (UIImage*)imageAsGreyscale:(CGFloat)scale
{
	int width = self.size.width;
	int height = self.size.height;
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
	
	CGContextRef context = CGBitmapContextCreate (nil,
												  width,
												  height,
												  8,      // bits per component
												  0,
												  colorSpace,
												  kCGImageAlphaNone);
	
	CGColorSpaceRelease(colorSpace);
	
	if (context != NULL)
	{
		CGRect area = CGRectMake(0, 0, width, height);
		
		if (scale <= 1.0f)
		{
			CGContextSetRGBFillColor(context, scale,scale,scale,1.0f);
		}
		else
		{
			CGContextSetRGBFillColor(context, scale-1.0f,scale-1.0f,scale-1.0f,1.0f);
		}
		
		
		CGContextFillRect(context, area);
		
		CGContextSetBlendMode(context, kCGBlendModeMultiply);
		CGContextDrawImage(context,CGRectMake(0, 0, width, height), self.CGImage);
		
		if (scale > 1.0f)
		{
			CGContextSetBlendMode(context, kCGBlendModePlusLighter);
			CGContextDrawImage(context,CGRectMake(0, 0, width, height), self.CGImage);
		}
		
        CGImageRef temp = CGBitmapContextCreateImage(context);
		UIImage* grayImage = [UIImage imageWithCGImage:temp];
        CGImageRelease(temp);
		CGContextRelease(context);
		
		return grayImage;
	}	
	return nil;
}


- (UIImage*)imageByColourising:(UIColor *)theColor
{
    UIGraphicsBeginImageContext(self.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, area, self.CGImage);
    
    [theColor set];
    CGContextFillRect(ctx, area);
	
    CGContextRestoreGState(ctx);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextDrawImage(ctx, area, self.CGImage);
		
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
