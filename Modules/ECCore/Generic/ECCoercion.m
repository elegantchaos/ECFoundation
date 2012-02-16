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

+ (NSDictionary*)loadDictionary:(id)dictionaryOrPlistName
{
    if ([dictionaryOrPlistName isKindOfClass:[NSString class]])
    {
        NSURL* url = [[NSBundle mainBundle] URLForResource:dictionaryOrPlistName withExtension:@"plist"];
        dictionaryOrPlistName = [NSDictionary dictionaryWithContentsOfURL:url];
    }
    
    return dictionaryOrPlistName;
}

+ (NSArray*)loadArray:(id)arrayOrPlistName
{
    if ([arrayOrPlistName isKindOfClass:[NSString class]])
    {
        NSURL* url = [[NSBundle mainBundle] URLForResource:arrayOrPlistName withExtension:@"plist"];
        arrayOrPlistName = [NSArray arrayWithContentsOfURL:url];
    }

    return arrayOrPlistName;
}

@end
