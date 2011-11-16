//
//  TestClass.m
//  ECLazySample
//
//  Created by Sam Deane on 15/11/2011.
//  Copyright (c) 2011 Elegant Chaos. All rights reserved.
//

#import "TestClass2.h"

#import <objc/runtime.h>
#import </usr/include/objc/objc-class.h>

@interface NSObject(Lazy)

- (id)setLazyForProperty:(NSString*)property init:(id)init;
+ (void)initializeLazy;

@end

@implementation NSObject(Lazy)

- (id)setLazyForProperty:(NSString*)property init:(id)init
{
    NSString* setter = [NSString stringWithFormat:@"set%@:", [property capitalizedString]];
    [self performSelector:NSSelectorFromString(setter) withObject:init];
    return init;
}

+ (void)initializeLazy
{
    uint count;
    objc_property_t* properties = class_copyPropertyList(self, &count);
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName = property_getName(properties[i]);
        SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%sInit", propertyName]);
        if ([self instancesRespondToSelector:sel])
        {
            NSLog(@"%s is lazy", propertyName);
            SEL sel2 = NSSelectorFromString([NSString stringWithFormat:@"%s", propertyName]);
            Method orig_method = class_getInstanceMethod(self, sel);
            Method alt_method = class_getInstanceMethod(self, sel2);
            
            method_exchangeImplementations(orig_method, alt_method);
        }
    }
    free(properties);
}
@end

#define lazy_init(name,value) \
id current = [self name##Init]; \
return current ? current : [self setLazyForProperty:@#name init:value]




@implementation TestClass2

@synthesize test;

void MethodSwizzle(Class aClass, SEL orig_sel, SEL alt_sel);
void MethodSwizzle(Class aClass, SEL orig_sel, SEL alt_sel)
{
    Method orig_method = class_getInstanceMethod(aClass, orig_sel);
    Method alt_method = class_getInstanceMethod(aClass, alt_sel);
    
    method_exchangeImplementations(orig_method, alt_method);
}

- (id)setLazyForProperty:(NSString*)property init:(id)init
{
    NSString* setter = [NSString stringWithFormat:@"set%@:", [property capitalizedString]];
    [self performSelector:NSSelectorFromString(setter) withObject:init];
    return init;
}

#define lazy_init(name,value) \
    id current = [self name##Init]; \
    return current ? current : [self setLazyForProperty:@#name init:value]

+ (void)initialize
{
    uint count;
    objc_property_t* properties = class_copyPropertyList(self, &count);
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName = property_getName(properties[i]);
        SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%sInit", propertyName]);
        if ([self instancesRespondToSelector:sel])
        {
            NSLog(@"%s is lazy", propertyName);
            SEL sel2 = NSSelectorFromString([NSString stringWithFormat:@"%s", propertyName]);
            MethodSwizzle(self, sel, sel2);
        }
    }
    free(properties);
}

- (NSString*)testInit
{
    lazy_init(test, @"test");
}

@end