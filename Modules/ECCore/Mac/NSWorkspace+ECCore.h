// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 17/03/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------


@interface NSWorkspace(ECCore)

- (BOOL)		selectURL:(NSURL*)fullPath inFileViewerRootedAtURL:(NSURL*)rootFullPath;
- (BOOL)		selectURLOnDesktop:(NSURL*)fullPath;
- (BOOL)        selectURLIntelligently:(NSURL*)url;

- (BOOL)		isFilePackageAtURL:(NSURL*)fullPath;
- (NSImage*)	iconForURL:(NSURL*)fullPath;
- (NSURL*)		urlOfFrontWindow;
- (NSArray*)	urlsOfSelection;

@end
