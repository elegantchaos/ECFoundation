
// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 16/06/11
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECProperties.h"

@interface ECDraggableArrayController : NSArrayController
{
    ECPropertyVariable(table, NSTableView*);
    ECPropertyVariable(supportedTypes, NSArray*);
    ECPropertyVariable(canCopy, BOOL);
}

ECPropertyRetained(table, NSTableView*);
ECPropertyRetained(supportedTypes, NSArray*);
ECPropertyAssigned(canCopy, BOOL);

// --------------------------------------------------------------------------
// Methods That Subclasses Can Extend (should call super)
// --------------------------------------------------------------------------

- (NSDragOperation)localSourceMaskToUse;
- (NSDragOperation)remoteSourceMaskToUse;
- (NSArray*)typesToRegister;
- (NSArray*)typesToDragForRows:(NSIndexSet*)rowIndexes;
- (void)writeDataOfType:(NSString*)type toPasteboard:(NSPasteboard*)pasteboard forRows:(NSIndexSet*)rowIndexes;
- (BOOL)performMoveToRow:(NSUInteger)row withPasteboard:(NSPasteboard*)pasteboard;
- (BOOL)performLocalCopyToRow:(NSUInteger)row withPasteboard:(NSPasteboard*)pasteboard;
- (BOOL)performRemoteCopyToRow:(NSUInteger)row withPasteboard:(NSPasteboard*)pasteboard;

#ifndef ECPropertyVariable
@property () IBOutlet NSTableView* table;
#endif

@end


