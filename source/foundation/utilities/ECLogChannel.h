//
//  ECLogChannel.h
//  ECFoundation
//
//  Created by Sam Deane on 26/08/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ECLogChannel : NSObject
{
	
}

ECPropertyDefineAN(enabled, BOOL);
ECPropertyDefineRN(name, NSString*);

- (void) logWithFormat: (NSString*) format arguments: (va_list) arguments;

@end

