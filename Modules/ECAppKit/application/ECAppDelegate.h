// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 28/11/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECAboutBoxInfoProvider.h"
#import "ECProperties.h"

@class ECPreferencesController;
@class ECAboutBoxController;
@class ECLicenseChecker;

@interface ECAppDelegate : NSObject <NSApplicationDelegate, ECAboutBoxInfoProvider> 
{
	ECPropertyVariable(aboutController, ECAboutBoxController*);
	ECPropertyVariable(preferencesController, ECPreferencesController*);
	ECPropertyVariable(licenseChecker, ECLicenseChecker*);
    
    IBOutlet NSMenu*             mDockMenu;
    IBOutlet NSMenu*             mStatusMenu;
    IBOutlet NSMenu*             mApplicationMenu;
}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

ECPropertyRetained(aboutController, ECAboutBoxController*);
ECPropertyRetained(preferencesController, ECPreferencesController*);
ECPropertyRetained(licenseChecker, ECLicenseChecker*);

@property (assign, nonatomic)	IBOutlet NSMenu*						statusMenu;
@property (assign, nonatomic)	IBOutlet NSMenu*						dockMenu;

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

@end
