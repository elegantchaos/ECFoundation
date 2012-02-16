//
//  ECCoercion.h
//  ECTableBindingsSample
//
//  Created by Sam Deane on 16/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECCoercion : NSObject

+ (Class)asClass:(id)classOrClassName;
+ (NSString*)asClassName:(id)classOrClassName;
+ (NSArray*)asArray:(id)arrayOrObject;

+ (NSDictionary*)loadDictionary:(id)dictionaryOrPlistName;
+ (NSArray*)loadArray:(id)arrayOrPlistName;

@end
