//
//  ECLogManager.h
//  ECFoundation
//
//  Created by Sam Deane on 26/08/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ECLogChannel;

@interface ECLogManager : NSObject
{
	ECPropertyVariable(channels, NSMutableArray*);
}

ECPropertyRetained(channels, NSMutableArray*);

+ (ECLogManager*) sharedInstance;

- (void) registerChannel: (ECLogChannel*) channel;

@end
