// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/12/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECCoreDataModelController.h"

#import <ECFoundation/NSFileManager+ECCore.h>
#import <ECFoundation/NSArray+ECCore.h>
#import <ECFoundation/UIApplication+ECCore.h>
#import <ECFoundation/NSBundle+ECCore.h>

#import <CoreData/CoreData.h>

@interface ECCoreDataModelController()

@property (nonatomic, retain) NSManagedObjectModel* managedObjectModel;
@property (nonatomic, retain) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSPersistentStoreCoordinator* persistentStoreCoordinator;

- (void)startupCoreData;
- (void)shutdownCoreData;

@end

@implementation ECCoreDataModelController

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


#if 0
- (Author*)authorWithName:(NSString*)name
{
    NSError* error = nil;
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"CDAuthor" inManagedObjectContext:self.managedObjectContext];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:request error:&error];
    Author* result = [fetchedObjects firstObjectOrNil];
    [request release];
    if (!result)
    {
        NSLog(@"made author %@", name);
        result = [NSEntityDescription insertNewObjectForEntityForName:@"CDAuthor" inManagedObjectContext:self.managedObjectContext];
        result.name = name;
        [self.managedObjectContext save:&error];
    }
    else
    {
        NSLog(@"retrieved author %@", name);
    }
    
    return result;
}
#endif

@end