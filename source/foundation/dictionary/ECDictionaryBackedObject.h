// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
//! Objects inheriting from this can be created / updated from a dictionary.
//! The dictionary is expected to always contain at least one value, which represents
//! a unique ID for the object. The key used to store this value is defined by
//! the class method objectIDKey, which should be overridden in each subclass.
//!
//! Typically you should use the DictionaryBackedObjectCache class to manage
//! collections of objects, rather than dealing with this API directly.
// --------------------------------------------------------------------------

@interface ECDictionaryBackedObject : NSObject 
{
@private
	NSMutableDictionary* data;
}

@property (nonatomic, retain) NSMutableDictionary* data;

+ (NSString*)objectIDFromDictionary:(NSDictionary*)dictionary;
+ (ECDictionaryBackedObject*)objectWithDictionary:(NSDictionary*)dictionary;
+ (NSString*)objectIDKey;

- (id)initWithDictionary:(NSDictionary*)dictionary;
- (void)updateFromDictionary:(NSDictionary*)dictionary;
- (NSDictionary*)asDictionary;

- (NSString*)objectID;
- (NSDate*)objectCreationDate;
- (NSDate*)objectUpdateDate;
- (void)rememberUpdate;

+ (void)loadObjectsFromURL:(NSURL*)url intoDictionary:(NSMutableDictionary*)dictionary;
+ (void)saveObjectsToURL:(NSURL*)url fromDictionary:(NSDictionary*)dictionary;
@end
