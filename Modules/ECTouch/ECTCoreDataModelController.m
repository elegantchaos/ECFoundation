// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/12/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTCoreDataModelController.h"

#import "NSFileManager+ECCore.h"
#import "NSArray+ECCore.h"
#import "UIApplication+ECCore.h"
#import "NSBundle+ECCore.h"

#import "ECLogging.h"

#import <CoreData/CoreData.h>

@interface ECTCoreDataModelController()

@property (nonatomic, retain) NSManagedObjectModel* managedObjectModel;
@property (nonatomic, retain) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSPersistentStoreCoordinator* persistentStoreCoordinator;

@end

@implementation ECTCoreDataModelController

@synthesize managedObjectModel;
@synthesize managedObjectContext;
@synthesize persistentStoreCoordinator;

- (void)dealloc
{
    [managedObjectModel release];
	[managedObjectContext release];
	[persistentStoreCoordinator release];
    
    [super dealloc];
}

- (void)startup
{
	[super startup];
	[self startupCoreData];
}

- (void)shutdown
{
	[self shutdownCoreData];
	[super shutdown];
}

#pragma mark -
#pragma mark Core Data

- (void)startupCoreData
{
    self.managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
	NSDictionary* info = [[NSBundle mainBundle] infoDictionary];
	NSString* name = [info objectForKey:@"ECCoreDataName"];
	NSString* version = [info objectForKey:@"ECCoreDataVersion"];
	
    NSURL* url = [[NSFileManager defaultManager] URLForApplicationDataPath:@"data"];
    url = [url URLByAppendingPathComponent:[NSString stringWithFormat:@"%@-v%@.sqllite", name, version]];

	NSError *error = nil;
    NSPersistentStoreCoordinator* psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    if ([psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error])
    {
        NSManagedObjectContext* moc = [[NSManagedObjectContext alloc] init];
        [moc setPersistentStoreCoordinator:psc];
        self.persistentStoreCoordinator = psc;
        self.managedObjectContext = moc;
        [moc release];
    }
    [psc release];
}

- (void)shutdownCoreData
{
	
}

- (id)findOrCreateEntityForName:(NSString*)entityName forKey:(NSString*)key value:(NSString*)value wasFound:(BOOL*)wasFound
{
    NSError* error = nil;
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"%@ == %@", key, value];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:request error:&error];
    NSManagedObject* result = [fetchedObjects firstObjectOrNil];
    [request release];
	if (wasFound)
	{
		*wasFound = (result != nil);
	}
	
    if (result)
    {
        ECDebug(ModelChannel, @"retrieved %@ with %@ == %@, %@", entityName, key, value, result);
	}
	else
	{
        ECDebug(ModelChannel, @"made %@ with %@ == %@, %@", entityName, key, value, result);
        result = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.managedObjectContext];
		[result setValue:value forKey:key];
        [self.managedObjectContext save:&error];
    }
    
    return result;
}


- (NSArray*)allEntitiesForName:(NSString*)entityName
{
    NSError* error = nil;
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    NSArray* result = [self.managedObjectContext executeFetchRequest:request error:&error];
    [request release];
	
    if (result)
    {
        ECDebug(ModelChannel, @"retrieved %d %@ entities", [result count], entityName);
	}
	else
	{
        ECDebug(ModelChannel, @" couldn't get %@ entities, error: @%", entityName, result);
    }
    
    return result;
}

- (void)save
{
	NSError* error = nil;
	[self.managedObjectContext save:&error];
}

@end
