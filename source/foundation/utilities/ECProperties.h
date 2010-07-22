//
//  ECProperties.h
//  ECFoundation
//
//  Created by Sam Deane on 22/07/2010.
//  Copyright 2010 Elegant Chaos. All rights reserved.
//

#import <Foundation/Foundation.h>


#define ECDefinePropertyMember(name, type)		type _##name

#define ECDefineProperty(name, type, ...)		@property (__VA_ARGS__) type name

#define ECSynthesizeProperty(name)				@synthesize name = _##name

#define ECPropertyMember(name)					_##name

#define ECPropertyRelease(name)					[_##name release]

@interface ECProperties : NSObject 
{

}

@end
