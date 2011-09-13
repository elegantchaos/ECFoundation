// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 07/03/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
//  Based on original code by Matt Gemmell.
// --------------------------------------------------------------------------

#import <Cocoa/Cocoa.h>

@interface ECPreferencesController : NSObject<NSToolbarDelegate, NSWindowDelegate>
{
    NSWindow *prefsWindow;
    NSMutableDictionary *preferencePanes;
    NSMutableArray *panesOrder;

    NSString *bundleExtension;
    NSString *searchPath;
    
    NSToolbar *prefsToolbar;
    NSMutableDictionary *prefsToolbarItems;

    NSToolbarDisplayMode toolbarDisplayMode;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
    NSToolbarSizeMode toolbarSizeMode;
#endif
    BOOL usesTexturedWindow;
    BOOL alwaysShowsToolbar;
    BOOL alwaysOpensCentered;
    
    BOOL debug;
}

// Convenience constructors
+ (id)preferencesWithPanesSearchPath:(NSString*)path bundleExtension:(NSString *)ext;
+ (id)preferencesWithBundleExtension:(NSString *)ext;
+ (id)preferencesWithPanesSearchPath:(NSString*)path;
+ (id)preferences;

// Designated initializer
- (id)initWithPanesSearchPath:(NSString*)path bundleExtension:(NSString *)ext;

- (id)initWithBundleExtension:(NSString *)ext;
- (id)initWithPanesSearchPath:(NSString*)path;

- (void)showPreferencesWindow;
- (void)createPreferencesWindowAndDisplay:(BOOL)shouldDisplay;
- (void)createPreferencesWindow;
- (void)destroyPreferencesWindow;
- (BOOL)loadPrefsPaneNamed:(NSString *)name display:(BOOL)disp;
- (BOOL)loadPreferencePaneNamed:(NSString *)name;
- (void)activatePane:(NSString*)path;
- (void)debugLog:(NSString*)msg;

float ToolbarHeightForWindow(NSWindow *window);
- (void)createPrefsToolbar;
- (void)prefsToolbarItemClicked:(NSToolbarItem*)item;

// Accessors
- (NSWindow *)preferencesWindow;
- (NSString *)bundleExtension;
- (NSString *)searchPath;

- (NSArray *)loadedPanes;
- (NSArray *)panesOrder;
- (void)setPanesOrder:(NSArray *)newPanesOrder;
- (BOOL)debug;
- (void)setDebug:(BOOL)newDebug;
- (BOOL)usesTexturedWindow;
- (void)setUsesTexturedWindow:(BOOL)newUsesTexturedWindow;
- (BOOL)alwaysShowsToolbar;
- (void)setAlwaysShowsToolbar:(BOOL)newAlwaysShowsToolbar;
- (BOOL)alwaysOpensCentered;
- (void)setAlwaysOpensCentered:(BOOL)newAlwaysOpensCentered;
- (NSToolbarDisplayMode)toolbarDisplayMode;
- (void)setToolbarDisplayMode:(NSToolbarDisplayMode)displayMode;
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
- (NSToolbarSizeMode)toolbarSizeMode;
- (void)setToolbarSizeMode:(NSToolbarSizeMode)sizeMode;
#endif

@end
