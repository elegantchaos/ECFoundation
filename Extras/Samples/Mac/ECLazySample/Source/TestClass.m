//
//  TestClass.m
//  ECLazySample
//
//  Created by Sam Deane on 15/11/2011.
//  Copyright (c) 2011 Elegant Chaos. All rights reserved.
//

#import "TestClass.h"

@lazy_implementation(TestClass)

@synthesize test;

- (NSString*)testInit
{
    return @"test";
}

@lazy_properties(TestClass)

@lazy_synthesize(test)

@end_lazy_implementation(TestClass)
