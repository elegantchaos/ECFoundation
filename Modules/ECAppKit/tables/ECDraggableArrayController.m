// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 16/06/11
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECDraggableArrayController.h"
#import "ECLogging.h"
#import "ECAssertion.h"

#import "NSIndexSet+ECCore.h"

#pragma mark - Private Methods

@interface ECDraggableArrayController()

- (BOOL)tableView:(NSTableView *)aTableView writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard *)pboard;
- (NSDragOperation)tableView:(NSTableView*)tv validateDrop:(id <NSDraggingInfo>)info proposedRow:(int)row proposedDropOperation:(NSTableViewDropOperation)op;
- (BOOL)tableView:(NSTableView*)tv acceptDrop:(id <NSDraggingInfo>)info row:(int)row dropOperation:(NSTableViewDropOperation)op;

-(NSIndexSet *) moveObjectsInArrangedObjectsFromIndexes:(NSIndexSet*)fromIndexSet toIndex:(NSUInteger)insertIndex;

@end

#pragma mark - Constants

NSString *const RowIndexesType = @"com.elegantchaos.ecappkit.rowindexes";

@implementation ECDraggableArrayController

#pragma mark - Debug Channels

ECDefineDebugChannel(ECDraggableArrayControllerChannel);

#pragma mark - Properties

ECPropertySynthesize(supportedTypes);
ECPropertySynthesize(table);
ECPropertySynthesize(canCopy);

#pragma mark - Lifecycle

// --------------------------------------------------------------------------
//! Set up the table for dragging.
// --------------------------------------------------------------------------

- (void)awakeFromNib
{
    ECAssertNonNil(self.table);
    
    // setup masks
	[self.table setDraggingSourceOperationMask:[self remoteSourceMaskToUse] forLocal:NO];
	[self.table setDraggingSourceOperationMask:[self localSourceMaskToUse] forLocal:YES];

    // register types
    self.supportedTypes = [self typesToRegister];
	[self.table registerForDraggedTypes:self.supportedTypes];
	
	[super awakeFromNib];

    ECDebug(ECDraggableArrayControllerChannel, @"set up table %@ for dragging with types %@", self.table, self.supportedTypes);
}

// --------------------------------------------------------------------------
//! Clean up.
// --------------------------------------------------------------------------

- (void)dealloc
{
    ECPropertyDealloc(supportedTypes);
    ECPropertyDealloc(table);
    
    [super dealloc];
}

// --------------------------------------------------------------------------
//! Return mask to use for local drags.
// --------------------------------------------------------------------------

- (NSDragOperation)localSourceMaskToUse
{
    NSDragOperation mask = NSDragOperationMove;
    if (self.canCopy)
    {
        mask |= NSDragOperationCopy; 
    }
    
    return mask;
}

// --------------------------------------------------------------------------
//! Return mask to use for remote drags.
// --------------------------------------------------------------------------

- (NSDragOperation)remoteSourceMaskToUse
{
    return 0;
}

// --------------------------------------------------------------------------
//! Return drag types that we support.
// --------------------------------------------------------------------------

- (NSArray*)typesToRegister
{
    return [NSArray arrayWithObject:RowIndexesType];
}

// --------------------------------------------------------------------------
//! Return types to write when starting a drag of some rows.
// --------------------------------------------------------------------------

- (NSArray*)typesToDragForRows:(NSIndexSet*)rowIndexes
{
    return [NSArray arrayWithObject:RowIndexesType];
}

// --------------------------------------------------------------------------
//! Write data of a particular type to a pasteboard for some rows.
// --------------------------------------------------------------------------

- (void)writeDataOfType:(NSString*)type toPasteboard:(NSPasteboard*)pasteboard forRows:(NSIndexSet*)rowIndexes
{
    if ([type isEqualToString:RowIndexesType])
    {
        ECDebug(ECDraggableArrayControllerChannel, @"writing row indexes for table %@", self.table);

        NSData* rowIndexesArchive = [NSKeyedArchiver archivedDataWithRootObject:rowIndexes];
        [pasteboard setData:rowIndexesArchive forType:RowIndexesType];
    }
}

// --------------------------------------------------------------------------
//! Is a given drag a copy operation?
// --------------------------------------------------------------------------

- (BOOL)dragIsCopyForTableView:(NSTableView*)tableView info:(id <NSDraggingInfo>)info
{
    // by default we do a copy
    BOOL isCopy = YES;
    
    // if the move is internal, and the option key isn't pressed, we move instead
    if ([info draggingSource] == tableView) 
    {
		NSEvent* currentEvent = [NSApp currentEvent];
		BOOL optionKeyPressed = ([currentEvent modifierFlags] & NSAlternateKeyMask) != 0;
        isCopy = self.canCopy && optionKeyPressed;
    }
    
    return isCopy;
}

// --------------------------------------------------------------------------
//! Perform a move of some rows.
// --------------------------------------------------------------------------

- (BOOL)performMoveToRow:(NSUInteger)row withPasteboard:(NSPasteboard*)pasteboard
{
    NSData* rowsData = [pasteboard dataForType:RowIndexesType];
    NSIndexSet* indexSet = [NSKeyedUnarchiver unarchiveObjectWithData:rowsData];

    NSIndexSet *destinationIndexes = [self moveObjectsInArrangedObjectsFromIndexes:indexSet toIndex:row];

    // set selected rows to those that were just moved
    [self setSelectionIndexes:destinationIndexes];
    
    ECDebug(ECDraggableArrayControllerChannel, @"moved rows %@ to %@ for table %@", indexSet, destinationIndexes, self.table);

    return YES;
}

// --------------------------------------------------------------------------
//! Perform a local copy of some rows.
// --------------------------------------------------------------------------

- (BOOL)performLocalCopyToRow:(NSUInteger)row withPasteboard:(NSPasteboard*)pasteboard
{
    ECDebug(ECDraggableArrayControllerChannel, @"copied rows for table %@", self.table);

    return NO;
}

// --------------------------------------------------------------------------
//! Perform a remote copy of some data from elsewhere.
// --------------------------------------------------------------------------

- (BOOL)performRemoteCopyToRow:(NSUInteger)row withPasteboard:(NSPasteboard*)pasteboard
{
    ECDebug(ECDraggableArrayControllerChannel, @"accepted drop for table %@", self.table);

    return NO;
}



-(NSIndexSet *) moveObjectsInArrangedObjectsFromIndexes:(NSIndexSet*)fromIndexSet toIndex:(NSUInteger)insertIndex
{	
	// If any of the removed objects come before the insertion index,
	// we need to decrement the index appropriately
	NSUInteger adjustedInsertIndex =
	insertIndex - [fromIndexSet countOfIndexesInRange:(NSRange){0, insertIndex}];
	NSRange destinationRange = NSMakeRange(adjustedInsertIndex, [fromIndexSet count]);
	NSIndexSet *destinationIndexes = [NSIndexSet indexSetWithIndexesInRange:destinationRange];
	
	NSArray *objectsToMove = [[self arrangedObjects] objectsAtIndexes:fromIndexSet];
	[self removeObjectsAtArrangedObjectIndexes:fromIndexSet];	
	[self insertObjects:objectsToMove atArrangedObjectIndexes:destinationIndexes];
	
	return destinationIndexes;
}


#pragma mark - NSTableViewDataSource Drag & Drop Methods

// --------------------------------------------------------------------------
//! Handle start of a drag.
// --------------------------------------------------------------------------

- (BOOL)tableView:(NSTableView *)aTableView writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard *)pboard
{
    NSArray* types = [self typesToDragForRows:rowIndexes];
    [pboard declareTypes:types owner:self];
    for (NSString* type in types)
    {
        [self writeDataOfType:type toPasteboard:pboard forRows:rowIndexes];
    }
    
    return YES;
}

// --------------------------------------------------------------------------
//! Validate a drop operation.
// --------------------------------------------------------------------------

- (NSDragOperation)tableView:(NSTableView*)tableView validateDrop:(id <NSDraggingInfo>)info proposedRow:(int)row proposedDropOperation:(NSTableViewDropOperation)op
{
	ECDebug(ECDraggableArrayControllerChannel, @"validate drop");

    // by default we do a copy
    BOOL isCopy = [self dragIsCopyForTableView:tableView info:info];
    NSDragOperation dragOp = isCopy ? NSDragOperationCopy : NSDragOperationMove;
    
    // we want to put the object at, not over, the current row (contrast NSTableViewDropOn) 
    [tableView setDropRow:row dropOperation:NSTableViewDropAbove];
	
    return dragOp;
}

// --------------------------------------------------------------------------
//! Accept a drop operation.
// --------------------------------------------------------------------------

- (BOOL)tableView:(NSTableView*)tableView acceptDrop:(id <NSDraggingInfo>)info row:(int)row dropOperation:(NSTableViewDropOperation)op
{
	ECDebug(ECDraggableArrayControllerChannel, @"accept drop");

    if (row < 0) 
    {
		row = 0;
	}
    
    NSPasteboard* pasteboard = [info draggingPasteboard];
    if (![self dragIsCopyForTableView:tableView info:info])
    {
        return [self performMoveToRow:row withPasteboard:pasteboard];
    }
    else if (tableView == [info draggingSource])
    {
        return [self performLocalCopyToRow:row withPasteboard:pasteboard];
    }
    else
    {
        return [self performRemoteCopyToRow:row withPasteboard:pasteboard];
    }
}

@end

