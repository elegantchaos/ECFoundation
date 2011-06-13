// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECDictionaryBackedObject.h"

#pragma mark - Private Interface

@interface ECDictionaryBackedObject()

@end

#pragma mark - Implementation

@implementation ECDictionaryBackedObject

ECDefineDebugChannel(DictionaryBackedObjectChannel);

#pragma mark - Properties

ECPropertySynthesize(data);

#pragma mark - Constants

NSString *const kObjectCreationDateKey = @"ECDictionaryBackedObjectObjectCreationDate";
NSString *const kObjectUpdateDateKey = @"ECDictionaryBackedObjectObjectUpdateDate";

#pragma mark - Object Lifecycle

// --------------------------------------------------------------------------
//! Return a new object constructed from a dictionary.
// --------------------------------------------------------------------------

+ (ECDictionaryBackedObject*)objectWithDictionary:(NSDictionary*)dictionary
{
    ECDictionaryBackedObject* object = [[[self class] alloc] initWithDictionary:dictionary];

    return [object autorelease];
}

// --------------------------------------------------------------------------
//! Initialise this object from a dictionary.
// --------------------------------------------------------------------------

- (id)initWithDictionary:(NSDictionary*)dictionary
{
    if ((self = [super init]) != nil)
    {
        self.data = [[dictionary mutableCopy] autorelease];
        NSDate* date = [NSDate date];
        [self.data setObject:date forKey:kObjectCreationDateKey]; 
        [self.data setObject:date forKey:kObjectUpdateDateKey]; 
    }
    
    return self;
}

// --------------------------------------------------------------------------
//! Cleanup.
// --------------------------------------------------------------------------

- (void)dealloc
{
	ECPropertyDealloc(data);
    
    [super dealloc];
}

#pragma mark - Dictionary Support

// --------------------------------------------------------------------------
//! Update the object from a dictionary.
//! Duplicate keys are replaced by the values in the dictionary.
//! Any keys already set in the object, but not present in the dictionary,
//! remain untouched. This method doesn't remove any entries in our dictionary.
// --------------------------------------------------------------------------

- (void)updateFromDictionary:(NSDictionary *)dictionary
{
    [self.data addEntriesFromDictionary:dictionary];
    [self rememberUpdate];
}

// --------------------------------------------------------------------------
//! Return this object as a dictionary.
//! By default we just return the internal dictionary, but this method could
//! be overridden to return a subset.
// --------------------------------------------------------------------------

- (NSDictionary*)asDictionary
{
    return self.data;
}

#pragma mark - Creation / Update Dates

// --------------------------------------------------------------------------
//! Return the date that this object was created. Note that this refers to
//! local creation, not some more abstract concept of the creation time of
//! whatever the object is representing...
// --------------------------------------------------------------------------

- (NSDate*)objectCreationDate
{
    return [self.data objectForKey:kObjectCreationDateKey];   
}

// --------------------------------------------------------------------------
//! Return the date that this object was last updated.
// --------------------------------------------------------------------------

- (NSDate*)objectUpdateDate
{
    return [self.data objectForKey:kObjectUpdateDateKey];   
}

// --------------------------------------------------------------------------
//! Record an update to the object.
// --------------------------------------------------------------------------

- (void)rememberUpdate
{
    NSDate* date = [NSDate date];
    [self.data setObject:date forKey:kObjectUpdateDateKey]; 
}

#pragma mark - Object ID

// --------------------------------------------------------------------------
//! Return the ID of an object as described by a dictionary.
//! We use this classes objectIDKey method to work out which key we're supposed
//! to look up.
// --------------------------------------------------------------------------

+ (NSString*)objectIDFromDictionary:(NSDictionary*)dictionary
{
    NSString* objectID = [dictionary objectForKey:[self objectIDKey]];
    return objectID;
}

// --------------------------------------------------------------------------
//! Return the ID of this object.
//! We use objectIDFromDictionary on our own dictionary to work out our ID.
// --------------------------------------------------------------------------

- (NSString*)objectID
{
    return [[self class] objectIDFromDictionary:self.data];
}

// --------------------------------------------------------------------------
//! Return the dictionary key to use when looking up object IDs for this class.
//! Subclasses should override this to return a relevant value.
// --------------------------------------------------------------------------

+ (NSString*)objectIDKey
{
    return @""; // subclasses should override this
}

// --------------------------------------------------------------------------
//! Load a group of objects from a plist into a dictionary, using their objectIDs
//! as keys.
//! The plist is assumed to contain an array of dictionaries - each one describing
//! one object.
//! Because the objectID is used as a key for each object in the dictionary,
//! only one copy of each object with a given id will end up in the dictionary,
//! even if the plist contained multiple copies.
// --------------------------------------------------------------------------

+ (void)loadObjectsFromURL:(NSURL*)url intoDictionary:(NSMutableDictionary*)dictionary
{
    NSArray* savedObjects = [NSArray arrayWithContentsOfURL:url];
    if (savedObjects)
    {
        Class class = [self class];
        [dictionary removeAllObjects];
        for (NSDictionary* objectData in savedObjects)
        {
            ECDictionaryBackedObject* object = [class objectWithDictionary:objectData];
            [dictionary setObject:object forKey:object.objectID];
        }
        
        ECDebug(DictionaryBackedObjectChannel, @"loaded cached %@s %@", class, [dictionary allKeys]);
    }
}

// --------------------------------------------------------------------------
//! Save a group of objects from a dictionary.
//! The dictionary is assumed to contain a group of objects.
//! Typically the keys will be the objectIDs, but they aren't actually checked
//! so if there are multiple copies of an object in the dictionary under different keys,
//! they will get saved multiple times.
//! The objects are written into a plist as an array of dictionaries.
// --------------------------------------------------------------------------

+ (void)saveObjectsToURL:(NSURL*)url fromDictionary:(NSDictionary*)dictionary
{
    NSMutableArray* objectsToSave = [NSMutableArray arrayWithCapacity:dictionary.count];
    for (ECDictionaryBackedObject* object in [dictionary allValues])
    {
        [objectsToSave addObject:[object asDictionary]];
    }
    [objectsToSave writeToURL:url atomically:YES];

    ECDebug(DictionaryBackedObjectChannel, @"cached %@s %@", [self class], [dictionary allKeys]);
}

@end
