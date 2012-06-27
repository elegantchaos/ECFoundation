// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 16/06/11
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECDraggableFileArrayController.h"

#pragma mark - Constants

@implementation ECDraggableFileArrayController

#pragma mark - Properties

// --------------------------------------------------------------------------
//! Return mask to use for remote drags.
// --------------------------------------------------------------------------

- (NSDragOperation)remoteSourceMaskToUse
{
    return [super remoteSourceMaskToUse] | NSDragOperationEvery;
}

// --------------------------------------------------------------------------
//! Return drag types that we support.
// --------------------------------------------------------------------------

- (NSArray*)typesToRegister
{
    return [[super typesToRegister] arrayByAddingObject:(NSString*)kUTTypeFileURL];
}

// --------------------------------------------------------------------------
//! Return types to write when starting a drag of some rows.
// --------------------------------------------------------------------------

- (NSArray*)typesToDragForRows:(NSIndexSet*)rowIndexes
{
    return [[super typesToDragForRows:rowIndexes] arrayByAddingObject:NSFilesPromisePboardType];
}

// --------------------------------------------------------------------------
//! Write data of a particular type to a pasteboard for some rows.
// --------------------------------------------------------------------------

- (void)writeDataOfType:(NSString*)type toPasteboard:(NSPasteboard*)pasteboard forRows:(NSIndexSet*)rowIndexes
{
    if ([type isEqualToString:NSFilesPromisePboardType])
    {
        // build array of file types
        NSMutableArray* types = [NSMutableArray arrayWithCapacity:[rowIndexes count]];
        NSArray* items = [[self arrangedObjects] objectsAtIndexes:rowIndexes];
        for (id item in items)
        {
			NSString* type = [self typeOfItem:item];
            [types addObject:type];
        }
        
        [pasteboard setPropertyList:types forType:NSFilesPromisePboardType];
        NSLog(@"written types %@", types);
    }
    else
    {
        [super writeDataOfType:type toPasteboard:pasteboard forRows:rowIndexes];
    }
}

// --------------------------------------------------------------------------
//! Copy/make the dropped items and return their names.
// --------------------------------------------------------------------------

- (NSArray*)namesOfPromisedFilesDroppedAtDestination:(NSURL *)dropDestination forDraggedRowsWithIndexes:(NSIndexSet *)indexSet
{
    NSMutableArray* names = [NSMutableArray arrayWithCapacity:[indexSet count]];
    NSArray* items = [[self arrangedObjects] objectsAtIndexes:indexSet];
    for (id item in items)
    {
        NSString* name = [self makeFileFromItem:item atDestination:dropDestination];
        [names addObject:name];
    }
    
    ECDebug(ECDraggableArrayControllerChannel, @"returning names %@ for dropped items %@", names, items);
    return names;
}

// --------------------------------------------------------------------------
//! Handle drop of files from a table.
// --------------------------------------------------------------------------

- (NSArray*)tableView:(NSTableView*)tableView namesOfPromisedFilesDroppedAtDestination:(NSURL*)destination forDraggedRowsWithIndexes:(NSIndexSet*)indexes 
{
	NSArray* result = [self namesOfPromisedFilesDroppedAtDestination:destination forDraggedRowsWithIndexes:indexes];
	
	return result;
}

// --------------------------------------------------------------------------
//! Handle drop of files form a collection view.
// --------------------------------------------------------------------------

- (NSArray *)collectionView:(NSCollectionView*)collectionView namesOfPromisedFilesDroppedAtDestination:(NSURL*)destination forDraggedItemsAtIndexes:(NSIndexSet *)indexes
{
	NSArray* result = [self namesOfPromisedFilesDroppedAtDestination:destination forDraggedRowsWithIndexes:indexes];
	
	return result;
}

// --------------------------------------------------------------------------
//! Perform a remote copy of files from elsewhere.
// --------------------------------------------------------------------------

- (BOOL)performRemoteCopyToIndex:(NSUInteger)index withPasteboard:(NSPasteboard*)pasteboard
{
    NSArray* classes = [NSArray arrayWithObject:[NSURL class]];
    NSDictionary* options = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:NSPasteboardURLReadingFileURLsOnlyKey];
    NSArray* urls = [pasteboard readObjectsForClasses:classes options:options];
    ECDebug(ECDraggableArrayControllerChannel, @"received urls %@", urls);
	BOOL result = [self addFiles:urls atIndex:index];
    
    return result;
}

// --------------------------------------------------------------------------
//! Return the file type to return for an item.
//! Subclasses should override this.
// --------------------------------------------------------------------------

- (NSString*)typeOfItem:(id)item
{
	return @""; 
}

// --------------------------------------------------------------------------
//! Make a file item and return its name.
//! Subclasses should override this.
// --------------------------------------------------------------------------

- (NSString*)makeFileFromItem:(id)item atDestination:(NSURL*)url
{
	return nil; 
}

// --------------------------------------------------------------------------
//! Add files dragged in from outside the application.
//! Subclasses should override this.
// --------------------------------------------------------------------------

- (BOOL)addFiles:(NSArray*)files atIndex:(NSInteger)index
{
	return YES;
}

@end

