
// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 16/06/11
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECDraggableArrayController.h"

@interface ECDraggableFileArrayController : ECDraggableArrayController

- (NSString*)typeOfItem:(id)item;
- (NSString*)makeFileFromItem:(id)item atDestination:(NSURL*)url;
- (BOOL)addFiles:(NSArray*)files atIndex:(NSInteger)index;

@end


