// --------------------------------------------------------------------------
//! @author Sam Deane
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@interface ModelObject : NSObject

@property (assign, nonatomic) BOOL enabled;
@property (strong, nonatomic) NSString* label;
@property (strong, nonatomic) NSString* option;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) UIImage* image;

@end
