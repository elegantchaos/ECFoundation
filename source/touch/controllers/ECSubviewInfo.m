//
//  ECSubviewInfo.m
//  ECFoundation
//
//  Created by Sam Deane on 22/07/2010.
//  Copyright 2010 Elegant Chaos. All rights reserved.
//

#import "ECSubviewInfo.h"


@implementation ECSubviewInfo

ECPropertySynthesize(classToUse);
ECPropertySynthesize(nib);

- (id) init
{
	if ((self = [super init]) != nil)
	{
		self.classToUse = [UIViewController class];
	}
	
	return self;
}
@end
