//
//  ECCoercion.m
//  ECTableBindingsSample
//
//  Created by Sam Deane on 16/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ECCoercion.h"

@implementation ECCoercion

+ (Class)asClass:(id)classOrClassName
{
    if ([classOrClassName isKindOfClass:[NSString class]])
    {
        classOrClassName = NSClassFromString(classOrClassName);
    }
    
    return classOrClassName;
}


+ (NSString*)asClassName:(id)classOrClassName
{
    if (![classOrClassName isKindOfClass:[NSString class]])
    {
        classOrClassName = NSStringFromClass(classOrClassName);
    }
    
    return classOrClassName;
}

+ (NSArray*)asArray:(id)arrayOrObject
{
    if (![arrayOrObject isKindOfClass:[NSArray class]])
    {
        arrayOrObject = [NSArray arrayWithObject:arrayOrObject];
    }
    
    return arrayOrObject;
}

@end
