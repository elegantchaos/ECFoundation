//
//  ECLogViewHandlerItem.h
//  ECLoggingSample
//
//  Created by Sam Deane on 02/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@class ECLogChannel;

@interface ECLogViewHandlerItem : NSObject

@property (nonatomic, retain) ECLogChannel* channel;
@property (nonatomic, retain) NSString* message;

@end
