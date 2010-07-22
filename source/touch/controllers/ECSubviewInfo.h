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
	ECDefinePropertyMember(classToUse, Class);
	ECDefinePropertyMember(nib, NSString*);
}

ECDefineProperty(classToUse, Class, assign, nonatomic);
ECDefineProperty(nib, NSString*, assign, nonatomic);

@end
