// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/12/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECModelController.h"

#import <CoreData/CoreData.h>

@class NSManagedObjectModel;
@class NSPersistentStoreCoordinator;
@class NSManagedObjectContext;

@interface ECCoreDataModelController : ECModelController

@property (nonatomic, retain, readonly) NSManagedObjectModel* managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator* persistentStoreCoordinator;

- (void)startupCoreData;
- (void)shutdownCoreData;

- (void)save;

- (id)findOrCreateEntityForName:(NSString*)entityName forKey:(NSString*)key value:(NSString*)value wasFound:(BOOL*)wasFound;

@end