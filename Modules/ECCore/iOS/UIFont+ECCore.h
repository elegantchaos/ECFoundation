// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/10/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *const ECFontNameKey;
extern NSString *const ECFontSizeKey;

@interface UIFont(ECCore)

+ (UIFont*)fontFromDictionary:(NSDictionary*)dictionary;
- (UIFont*)fontFromDictionary:(NSDictionary*)dictionary;

- (UIFont*)boldVariant;
- (UIFont*)italicVariant;

@end
