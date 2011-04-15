// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@class ECDictionaryBackedObject;


// --------------------------------------------------------------------------
//! This class is used to manage a cache of objects that inherit from 
//! ECDictionaryBackedObject.
//!
//! When you create a cache you pass it a class - it uses this to work out
//! which dictionary key to use for the objectID. It also uses the class to 
//! create new objects when it needs them.
//!
//! When you want to lookup an object in the cache, you can do so by objectID.
//! Alternatively, you can pass the cache a dictionary describing the object.
//! If the object exists already, it will be updated with the values in the 
//! dictionary, then returned to you. If it doesn't exist, it will be created
//! using the dictionary, and added to the cache before being returned.
//! 
//! You can save/load the contents of the cache to a file.
// --------------------------------------------------------------------------

@interface ECDictionaryBackedObjectCache : NSObject 

- (id)initWithClass:(Class)class;

- (ECDictionaryBackedObject*)objectWithID:(NSString*)objectID;
- (ECDictionaryBackedObject*)objectWithDictionary:(NSDictionary*)dictionary;
- (NSArray*)objectsWithArray:(NSArray*)array;
- (NSArray*)allObjects;
- (void)loadObjectsFromURL:(NSURL*)path;
- (void)saveObjectsToURL:(NSURL*)path;

- (void)removeObjectsOlderThanDate:(NSDate*)date;

@end
