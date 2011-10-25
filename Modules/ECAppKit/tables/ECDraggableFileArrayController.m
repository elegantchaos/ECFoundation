// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 16/06/11
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECDraggableFileArrayController.h"

#pragma mark - Constants

@implementation ECDraggableFileArrayController

#pragma mark - Properties


// --------------------------------------------------------------------------
//! Copy/make the dropped items and return their names.
// --------------------------------------------------------------------------

- (NSArray *)tableView:(NSTableView *)aTableView namesOfPromisedFilesDroppedAtDestination:(NSURL *)dropDestination forDraggedRowsWithIndexes:(NSIndexSet *)indexSet 
{
    NSMutableArray* names = [NSMutableArray arrayWithCapacity:[indexSet count]];
    NSArray* items = [[self arrangedObjects] objectsAtIndexes:indexSet];
    for (id item in items)
    {
        NSString* name = [self makeFileFromItem:item atDestination:dropDestination];
        [names addObject:name];
    }
    
    return names;
}

// --------------------------------------------------------------------------
//! Make a file item and return its name.
//! Subclasses should override this.
// --------------------------------------------------------------------------

- (NSString*)makeFileFromItem:(id)item atDestination:(NSURL*)url
{
	return nil;
}

@end

