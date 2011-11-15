
// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 16/06/11
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECLogging.h"

ECDeclareDebugChannel(ECDraggableArrayControllerChannel);

@interface ECDraggableArrayController : NSArrayController<NSCollectionViewDelegate>

@property (nonatomic, assign) BOOL canCopy;
@property (nonatomic, retain) IBOutlet NSCollectionView* collection;
@property (nonatomic, retain) NSArray* supportedTypes;
@property (nonatomic, retain) IBOutlet NSTableView* table;

// --------------------------------------------------------------------------
// Methods That Subclasses Can Extend (should call super)
// --------------------------------------------------------------------------

- (NSDragOperation)localSourceMaskToUse;
- (NSDragOperation)remoteSourceMaskToUse;
- (NSArray*)typesToRegister;
- (NSArray*)typesToDragForRows:(NSIndexSet*)rowIndexes;
- (void)writeDataOfType:(NSString*)type toPasteboard:(NSPasteboard*)pasteboard forRows:(NSIndexSet*)rowIndexes;
- (BOOL)performMoveToIndex:(NSUInteger)index withPasteboard:(NSPasteboard*)pasteboard;
- (BOOL)performLocalCopyToIndex:(NSUInteger)index withPasteboard:(NSPasteboard*)pasteboard;
- (BOOL)performRemoteCopyToIndex:(NSUInteger)index withPasteboard:(NSPasteboard*)pasteboard;

@end


