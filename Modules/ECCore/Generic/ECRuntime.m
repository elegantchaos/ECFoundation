// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECRuntime.h"

#import <objc/runtime.h>

void class_replaceMethodIfMissing(Class class, SEL apiSelector, SEL replacementSelector)
{
	if (![class instancesRespondToSelector:apiSelector])
	{
		Method replacementMethod = class_getInstanceMethod(class, replacementSelector);
		IMP replacementImplementation = method_getImplementation(replacementMethod);
		const char* encoding = method_getTypeEncoding(replacementMethod);
		class_addMethod(class, apiSelector, replacementImplementation, encoding);
	}
}
