//
//  TestClass.m
//  ECLazySample
//
//  Created by Sam Deane on 15/11/2011.
//  Copyright (c) 2011 Elegant Chaos. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass_nonlazy

@synthesize test;

- (void)dealloc
{
    [test release];
    
    [super dealloc];
}

- (NSString*)initTest
{
    return @"test";
}

@end

@implementation TestClass

- (NSString*)test
{
    id value = [super test];
    if (!value)
    {
        value = [super initTest];
        self.test = value;
    }
    
    return value;
}

@end
