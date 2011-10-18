//
//  ECLogViewHandler.h
//  ECLoggingSample
//
//  Created by Sam Deane on 02/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ECLogHandler.h"

@class ECLogViewController;

@interface ECLogViewHandler : ECLogHandler

@property (nonatomic, retain) NSMutableArray* items;
@property (nonatomic, retain) ECLogViewController* view;

+ (ECLogViewHandler*)sharedInstance;

@end
