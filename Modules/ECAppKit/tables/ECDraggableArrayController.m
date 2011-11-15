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

@synthesize canCopy;
@synthesize collection;
@synthesize supportedTypes;
@synthesize table;

#pragma mark - Lifecycle

// --------------------------------------------------------------------------
//! Set up the table for dragging.
// --------------------------------------------------------------------------

- (void)awakeFromNib
{
    ECAssert((self.table != nil) || (self.collection != nil));
    ECAssert((self.table == nil) || (self.collection == nil));

	NSArray* types = [self typesToRegister];
	NSDragOperation remoteMask = [self remoteSourceMaskToUse];
	NSDragOperation localMask = [self localSourceMaskToUse];
	
    self.supportedTypes = types;
	if (self.table)
	{
		[self.table setDraggingSourceOperationMask:remoteMask forLocal:NO];
		[self.table setDraggingSourceOperationMask:localMask forLocal:YES];
		[self.table registerForDraggedTypes:self.supportedTypes];
	}
	else if (self.collection)
	{
		[self.collection setDraggingSourceOperationMask:remoteMask forLocal:NO];
		[self.collection setDraggingSourceOperationMask:localMask forLocal:YES];
		[self.collection registerForDraggedTypes:self.supportedTypes];
	}
	
	[super awakeFromNib];

    ECDebug(ECDraggableArrayControllerChannel, @"set up table %@ for dragging with types %@", self.table, self.supportedTypes);
}

// --------------------------------------------------------------------------
//! Clean up.
// --------------------------------------------------------------------------

- (void)dealloc
{
	[collection release];
	[supportedTypes release];
	[table release];
    
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

- (BOOL)dragIsCopyForView:(NSView*)view info:(id <NSDraggingInfo>)info
{
    // by default we do a copy
    BOOL isCopy = YES;
    
    // if the move is internal, and the option key isn't pressed, we move instead
    if ([info draggingSource] == view) 
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

- (BOOL)performMoveToIndex:(NSUInteger)index withPasteboard:(NSPasteboard*)pasteboard
{
    NSData* rowsData = [pasteboard dataForType:RowIndexesType];
    NSIndexSet* indexSet = [NSKeyedUnarchiver unarchiveObjectWithData:rowsData];

    NSIndexSet *destinationIndexes = [self moveObjectsInArrangedObjectsFromIndexes:indexSet toIndex:index];

    // set selected rows to those that were just moved
    [self setSelectionIndexes:destinationIndexes];
    
    ECDebug(ECDraggableArrayControllerChannel, @"moved items %@ to %@", indexSet, destinationIndexes);

    return YES;
}

// --------------------------------------------------------------------------
//! Perform a local copy of some rows.
// --------------------------------------------------------------------------

- (BOOL)performLocalCopyToIndex:(NSUInteger)index withPasteboard:(NSPasteboard*)pasteboard
{
    ECDebug(ECDraggableArrayControllerChannel, @"copied items");

    return NO;
}

// --------------------------------------------------------------------------
//! Perform a remote copy of some data from elsewhere.
// --------------------------------------------------------------------------

- (BOOL)performRemoteCopyToIndex:(NSUInteger)index withPasteboard:(NSPasteboard*)pasteboard
{
    ECDebug(ECDraggableArrayControllerChannel, @"accepted drop for table");

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

// --------------------------------------------------------------------------
//! Write some items to a pasteboard.
// --------------------------------------------------------------------------

- (BOOL)writeItemsWithIndexes:(NSIndexSet*)indexes toPasteboard:(NSPasteboard*)pasteboard
{
    NSArray* types = [self typesToDragForRows:indexes];
    [pasteboard declareTypes:types owner:self];
    for (NSString* type in types)
    {
        [self writeDataOfType:type toPasteboard:pasteboard forRows:indexes];
    }
    
    return YES;
}

- (BOOL)view:(NSView*)view acceptDrop:(id <NSDraggingInfo>)info index:(NSInteger)index dropOperation:(NSTableViewDropOperation)op
{
	ECDebug(ECDraggableArrayControllerChannel, @"accept drop");
	
    if (index < 0) 
    {
		index = 0;
	}
    
    NSPasteboard* pasteboard = [info draggingPasteboard];
    if (![self dragIsCopyForView:view info:info])
    {
        return [self performMoveToIndex:index withPasteboard:pasteboard];
    }
    else if (view == [info draggingSource])
    {
        return [self performLocalCopyToIndex:index withPasteboard:pasteboard];
    }
    else
    {
        return [self performRemoteCopyToIndex:index withPasteboard:pasteboard];
    }
}

#pragma mark - NSTableViewDataSource Drag & Drop Methods

// --------------------------------------------------------------------------
//! Handle start of a drag.
// --------------------------------------------------------------------------

- (BOOL)tableView:(NSTableView*)view writeRowsWithIndexes:(NSIndexSet*)indexes toPasteboard:(NSPasteboard*)pasteboard
{
	BOOL result = [self writeItemsWithIndexes:indexes toPasteboard:pasteboard];
	
	return result;
}

// --------------------------------------------------------------------------
//! Validate a drop operation.
// --------------------------------------------------------------------------

- (NSDragOperation)tableView:(NSTableView*)tableView validateDrop:(id <NSDraggingInfo>)info proposedRow:(int)row proposedDropOperation:(NSTableViewDropOperation)op
{
	ECDebug(ECDraggableArrayControllerChannel, @"validate drop");

    // by default we do a copy
    BOOL isCopy = [self dragIsCopyForView:tableView info:info];
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
	BOOL result = [self view:tableView acceptDrop:info index:row dropOperation:op];
	
	return result;
}

#pragma mark - NSCollectionViewDelegate Drag & Drop Methods

- (NSDragOperation)collectionView:(NSCollectionView*)collectionView validateDrop:(id<NSDraggingInfo>)info proposedIndex:(NSInteger*)proposedDropIndex dropOperation:(NSCollectionViewDropOperation*)proposedDropOperation
{
	ECDebug(ECDraggableArrayControllerChannel, @"validate drop");
	
    // by default we do a copy
    BOOL isCopy = [self dragIsCopyForView:collectionView info:info];
    NSDragOperation dragOp = isCopy ? NSDragOperationCopy : NSDragOperationMove;
    
    // we want to put the object at, not over, the current row (contrast NSTableViewDropOn) 
	//    [collectionView setDropRow:row dropOperation:NSTableViewDropAbove];
	
    return dragOp;

}

- (BOOL)collectionView:(NSCollectionView*)collectionView writeItemsAtIndexes:(NSIndexSet*)indexes toPasteboard:(NSPasteboard *)pasteboard
{
	BOOL result = [self writeItemsWithIndexes:indexes toPasteboard:pasteboard];
    
    return result;
}

- (BOOL)collectionView:(NSCollectionView *)collectionView acceptDrop:(id <NSDraggingInfo>)info index:(NSInteger)index dropOperation:(NSCollectionViewDropOperation)operation
{
	BOOL result = [self view:collectionView acceptDrop:info index:index dropOperation:operation];
	
	return result;
}

#if 0
– collectionView:canDragItemsAtIndexes:withEvent:
– collectionView:acceptDrop:index:dropOperation:
{

}
– collectionView:draggingImageForItemsAtIndexes:withEvent:offset:
– collectionView:writeItemsAtIndexes:toPasteboard:
#endif

@end

