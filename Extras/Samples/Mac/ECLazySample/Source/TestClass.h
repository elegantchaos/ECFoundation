//
//  TestClass.h
//  ECLazySample
//
//  Created by Sam Deane on 15/11/2011.
//  Copyright (c) 2011 Elegant Chaos. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import "ECLazyProperties.h"

@interface TestClass_nonlazy : NSObject

@property (nonatomic, retain) NSString* test;

@end

@interface TestClass : TestClass_nonlazy
@end
