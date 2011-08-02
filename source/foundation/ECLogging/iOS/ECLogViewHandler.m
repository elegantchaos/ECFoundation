//
//  ECLogViewHandler.m
//  ECLoggingSample
//
//  Created by Sam Deane on 02/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ECLogViewHandler.h"
#import "ECLogViewHandlerItem.h"

@implementation ECLogViewHandler

@synthesize items;

// --------------------------------------------------------------------------
//! Singleton instance.
// --------------------------------------------------------------------------

+ (ECLogViewHandler*)sharedInstance
{
    static ECLogViewHandler* gInstance = nil;
    if (!gInstance)
    {
        gInstance = [[ECLogViewHandler alloc] init];
    }
    
    return gInstance;
}

// --------------------------------------------------------------------------
//! Log.
// --------------------------------------------------------------------------


- (void) logFromChannel: (ECLogChannel*) channel withFormat: (NSString*) format arguments: (va_list) arguments
{
    NSMutableArray* itemList = self.items;
    if (!itemList)
    {
        itemList = [NSMutableArray array];
        self.items = itemList;
    }
    
    ECLogViewHandlerItem* item = [[ECLogViewHandlerItem alloc] init];
    item.message = [[[NSString alloc] initWithFormat:format arguments:arguments] autorelease];
    item.channel = channel;
    
    [itemList addObject:item];
    [item release];
}

@end
