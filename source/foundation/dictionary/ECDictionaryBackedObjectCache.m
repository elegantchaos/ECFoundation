// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECDictionaryBackedObjectCache.h"
#import "ECDictionaryBackedObject.h"

#pragma mark - Private Interface

@interface ECDictionaryBackedObjectCache()

ECPropertyAssigned(class, Class);
ECPropertyRetained(data, NSMutableDictionary*);

- (void)postUpdatedNotification;

@end

#pragma mark - Implementation

@implementation ECDictionaryBackedObjectCache

ECDefineDebugChannel(DictionaryBackedObjectCacheChannel);

#pragma mark - Properties

ECPropertySynthesize(class);
ECPropertySynthesize(data);

#pragma mark - Notifications

NSString* const ECDictionaryBackedObjectCacheUpdatedNotification = @"ECDictionaryBackedObjectCacheUpdatedNotification";

#pragma mark - Object Lifecycle

// --------------------------------------------------------------------------
//! Initialise a cache.
//! We are passed the class of objects that this cache will contain.
// --------------------------------------------------------------------------

- (id)initWithClass:(Class)classIn
{
    if ((self = [super init]) != nil)
    {
        self.class = classIn;
        self.data = [NSMutableDictionary dictionary];
    }
    
    return self;
}

// --------------------------------------------------------------------------
//! Clean up.
// --------------------------------------------------------------------------

- (void)dealloc
{
    self.data = nil;
    
    [super dealloc];
}

#pragma mark - Object Creation / Lookup

// --------------------------------------------------------------------------
//! Return the object with a given key, if it exists.
//! If the object doesn't exist, we return nil.
// --------------------------------------------------------------------------

- (ECDictionaryBackedObject*)objectWithID:(NSString*)objectID
{
    return [self.data objectForKey:objectID];
}

// --------------------------------------------------------------------------
//! Given a dictionary, return the object that it represents.
//! The dictionary is checked for an object ID. If we've already got an
//! object with that ID in the cache, we update it using the dictionary,
//! then return it.
//! If we've not got an object in the cache with the given ID, we create one,
//! and add it to the cache before returning it.
// --------------------------------------------------------------------------

- (ECDictionaryBackedObject*)objectWithDictionary:(NSDictionary*)dictionary
{
    NSString* objectID = [self.class objectIDFromDictionary:dictionary];
    ECDictionaryBackedObject* object = [self.data objectForKey:objectID];
    if (object)
    {
        [object updateFromDictionary:dictionary];
    }
    else
    {
        object = [self.class objectWithDictionary:dictionary];
        [self.data setObject:object forKey:objectID];
    }
    
	[self postUpdatedNotification];

    return object;
}

// --------------------------------------------------------------------------
//! Given an array of dictionaries, return an array of objects created from
//! them. Any objects already in the cache will be updated. Any new obejcts
//! are added to the cache.
// --------------------------------------------------------------------------

- (NSArray*)objectsWithArray:(NSArray*)array
{
    NSMutableArray* results = [NSMutableArray arrayWithCapacity:[array count]];
	if (array.count > 0)
	{
		for (NSDictionary* item in array)
		{
			ECDictionaryBackedObject* object = [self objectWithDictionary:item];
			[results addObject:object];
		}
		
		[self postUpdatedNotification];
	}

    return results;
 
}

// --------------------------------------------------------------------------
//! Load the cache from a plist file.
//! The plist file should contain an array of dictionaries.
// --------------------------------------------------------------------------

- (void)loadObjectsFromURL:(NSURL*)url
{
    [self.class loadObjectsFromURL:url intoDictionary:self.data];
	[self postUpdatedNotification];
}

// --------------------------------------------------------------------------
//! Save the cache to a plist file as an array of dictionaries.
// --------------------------------------------------------------------------

- (void)saveObjectsToURL:(NSURL*)url
{
    [self.class saveObjectsToURL:url fromDictionary:self.data];
}

// --------------------------------------------------------------------------
//! Remove any objects in the cache that were last updated earlier than a
//! given date.
// --------------------------------------------------------------------------

- (void)removeObjectsOlderThanDate:(NSDate*)date
{
    // we scan through and build up a list of ids to remove, then
    // remove them in a second phase, to avoid any possibility of 
    // confusion caused by removing items whilst iterating

    NSMutableArray* objectIDsToRemove = [[NSMutableArray alloc] init];
    for (ECDictionaryBackedObject* object in [self.data allValues])
    {
        if ([object.objectUpdateDate compare:date] == NSOrderedAscending)
        {
            [objectIDsToRemove addObject:object.objectID];
        }
    }
    
    for (NSString* objectID in objectIDsToRemove)
    {
        [self.data removeObjectForKey:objectID];
    }
    
    ECDebug(DictionaryBackedObjectCacheChannel, @"removed old %@s %@", self.class, objectIDsToRemove);
    [objectIDsToRemove release];
	
	[self postUpdatedNotification];
}

// --------------------------------------------------------------------------
//! Return every object in the cache.
// --------------------------------------------------------------------------

- (NSArray*)allObjects
{
	return [self.data allValues];
}

// --------------------------------------------------------------------------
//! Post notification that the cache has been updated.
// --------------------------------------------------------------------------

- (void)postUpdatedNotification
{
	NSNotification* notification = [NSNotification notificationWithName:ECDictionaryBackedObjectCacheUpdatedNotification object:self];
	NSNotificationQueue* nq = [NSNotificationQueue defaultQueue];
	
	[nq enqueueNotification:notification postingStyle:NSPostWhenIdle coalesceMask:NSNotificationCoalescingOnSender forModes:nil];
}

@end
