// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 28/11/2010
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECAboutBoxInfoProvider.h"

@class ECPreferencesController;
@class ECAboutBoxController;
@class ECLicenseChecker;

@interface ECAppDelegate : NSObject <NSApplicationDelegate, ECAboutBoxInfoProvider> 

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

@property (nonatomic, retain) ECAboutBoxController* aboutController;
@property (nonatomic, assign) IBOutlet NSMenu* applicationMenu;
@property (nonatomic, assign) IBOutlet NSMenu* dockMenu;
@property (nonatomic, assign) NSFileManager* fileManager;
@property (nonatomic, retain) ECLicenseChecker* licenseChecker;
@property (nonatomic, retain) ECPreferencesController* preferencesController;
@property (nonatomic, assign) IBOutlet NSMenu* statusMenu;

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (ECPreferencesController*)	getCachedPreferencesController;
- (NSArray*)					getPreferencePanes;
- (void)                        installLogHandlers;
- (BOOL)                        setupMacStore;
- (void)                        stripElegantChaosStoreItemsFromMenu: (NSMenu*) menu;
- (void)                        stripSparkleItemsFromMenu: (NSMenu*) menu;

// --------------------------------------------------------------------------
// Actions
// --------------------------------------------------------------------------

- (IBAction)	openSupport:						(id) sender;
- (IBAction)	openReleaseNotes:					(id) sender;
- (IBAction)	openWebsite:						(id) sender;
- (IBAction)	openStore:							(id) sender;
- (IBAction)	showHelp:							(id) sender;
- (IBAction)	showAboutBox:						(id) sender;
- (IBAction)	showPreferences:					(id) sender;
- (IBAction)    openLicenseFile:                    (id) sender;
- (IBAction)    showUserGuide:                      (id) sender;

@end
