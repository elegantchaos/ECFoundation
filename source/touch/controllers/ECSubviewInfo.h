//
//  ECSubviewInfo.h
//  ECFoundation
//
//  Created by Sam Deane on 22/07/2010.
//  Copyright 2010 Elegant Chaos. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ECProperties.h"

@interface ECSubviewInfo : NSObject 
{
	ECPropertyDefineVariable(classToUse, Class);
	ECPropertyDefineVariable(nib, NSString*);
}

ECPropertyDefine(classToUse, Class, assign, nonatomic);
ECPropertyDefine(nib, NSString*, assign, nonatomic);

@end
