//
//  ECLaunchAtLogin.m
//  ECFoundation
//
//  Created by Sam Deane on 08/09/2010.
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
//

#import "ECLaunchServices.h"


@implementation ECLaunchServices

// --------------------------------------------------------------------------
//! Return whether the item at a given URL is in the list of things
//! to open when the current user logs in.
// --------------------------------------------------------------------------

+ (BOOL) willOpenAtLogin:(NSURL*) itemURL
{
    Boolean foundIt=false;
    LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    if (loginItems) 
	{
        UInt32 seed = 0U;
        NSArray *currentLoginItems = [NSMakeCollectable(LSSharedFileListCopySnapshot(loginItems, &seed)) autorelease];
        for (id itemObject in currentLoginItems) 
		{
            LSSharedFileListItemRef item = (LSSharedFileListItemRef)itemObject;
			
            UInt32 resolutionFlags = kLSSharedFileListNoUserInteraction | kLSSharedFileListDoNotMountVolumes;
            CFURLRef URL = NULL;
            OSStatus err = LSSharedFileListItemResolve(item, resolutionFlags, &URL, /*outRef*/ NULL);
            if (err == noErr) 
			{
                foundIt = CFEqual(URL, itemURL);
                CFRelease(URL);
				
                if (foundIt)
                    break;
            }
        }
        CFRelease(loginItems);
    }
    return (BOOL)foundIt;
}

// --------------------------------------------------------------------------
//! Set whether the item at a given URL is in the list of things
//! to open when the current user logs in.
// --------------------------------------------------------------------------

+ (void) setOpenAtLogin:(NSURL*) itemURL enabled: (BOOL)enabled
{
    LSSharedFileListItemRef existingItem = NULL;
	
    LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    if (loginItems) 
	{
        UInt32 seed = 0U;
        NSArray *currentLoginItems = [NSMakeCollectable(LSSharedFileListCopySnapshot(loginItems, &seed)) autorelease];
        for (id itemObject in currentLoginItems) 
		{
            LSSharedFileListItemRef item = (LSSharedFileListItemRef)itemObject;
			
            UInt32 resolutionFlags = kLSSharedFileListNoUserInteraction | kLSSharedFileListDoNotMountVolumes;
            CFURLRef URL = NULL;
            OSStatus err = LSSharedFileListItemResolve(item, resolutionFlags, &URL, /*outRef*/ NULL);
            if (err == noErr) 
			{
                Boolean foundIt = CFEqual(URL, itemURL);
                CFRelease(URL);
				
                if (foundIt) 
				{
                    existingItem = item;
                    break;
                }
            }
        }
		
        if (enabled && (existingItem == NULL)) 
		{
            LSSharedFileListInsertItemURL(loginItems, kLSSharedFileListItemBeforeFirst,
                                          NULL, NULL, (CFURLRef)itemURL, NULL, NULL);
			
        }
		else if (!enabled && (existingItem != NULL))
		{
            LSSharedFileListItemRemove(loginItems, existingItem);
		}
		
        CFRelease(loginItems);
    }       
}

@end
