// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 28/11/2010
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECAppDelegate.h"
#import "ECPreferencesController.h"
#import "ECAboutBoxController.h"
#import "ECLicenseChecker.h"
#import "ECMacStore.h"
#import "ECMacStoreDifferentVersion.h"
#import "ECMacStoreExact.h"
#import "ECMacStoreTest.h"
#import "ECCompoundLicenseChecker.h"

#import "NSApplication+ECCore.h"
#import "NSFileManager+ECCore.h"

#import "ECLogging.h"
#import "ECLogManager.h"
#import "ECLogHandlerNSLog.h"
#import "ECLogHandlerStdout.h"
#import "ECLogHandlerStderr.h"
#import "ECErrorPresenterHandler.h"

// ==============================================
// Private Methods
// ==============================================

@interface ECAppDelegate()
@end


@implementation ECAppDelegate

ECDefineLogChannel(ECAppDelegateChannel);

#pragma mark - Constants

static NSString *const UserGuideType = @"pdf";

#pragma mark - Properties

@synthesize aboutController;
@synthesize applicationMenu;
@synthesize dockMenu;
@synthesize fileManager;
@synthesize licenseChecker;
@synthesize preferencesController;
@synthesize statusMenu;


#pragma mark - Lifecycle

- (void) dealloc
{
    [aboutController release];
    [preferencesController release];
    [licenseChecker release];

    [super dealloc];
}

// ==============================================
// Application Lifecycle
// ==============================================

#pragma mark - NSApplicationDelegate

// --------------------------------------------------------------------------
//! Finish setting up the application.
// --------------------------------------------------------------------------

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification 
{
	self.fileManager = [NSFileManager defaultManager];
	
    ECLogManager* lm = [ECLogManager sharedInstance];
	[self installLogHandlers];
    [lm startup];
}

// --------------------------------------------------------------------------
//! Clean up before the application dies.
// --------------------------------------------------------------------------

-(void)applicationWillTerminate:(NSNotification *)notification
{
	[[ECLogManager sharedInstance] shutdown];
	
}

// --------------------------------------------------------------------------
//! Handle the user opening a license file.
// --------------------------------------------------------------------------

- (BOOL)application:(NSApplication *)sender openFile:(NSString*) filename
{
    ECDebug(ECAppDelegateChannel, @"Request to open file: %@", filename);

    NSString* licenseFileType = [[NSApplication sharedApplication] licenseFileType];
	BOOL isLicenseFile = licenseFileType && [[filename pathExtension] isEqualToString: licenseFileType];
    if (isLicenseFile)
    {
        NSURL* licenseURL = [NSURL fileURLWithPath: filename];
        [self.licenseChecker registerLicenseFile: licenseURL];
    }
	
	return isLicenseFile;
}

#pragma mark - Logging

// --------------------------------------------------------------------------
//! Install Standard Log Handlers.
// --------------------------------------------------------------------------

- (void) installLogHandlers
{
    ECLogManager* lm = [ECLogManager sharedInstance];

	ECLogHandler* nslogHandler = [[ECLogHandlerNSLog alloc] init];
	[lm registerHandler: nslogHandler];
	[nslogHandler release];
    
	ECLogHandler* stdoutHandler = [[ECLogHandlerStdout alloc] init];
	[lm registerHandler: stdoutHandler];
	[stdoutHandler release];

    ECLogHandler* stderrHandler = [[ECLogHandlerStderr alloc] init];
	[lm registerHandler: stderrHandler];
	[stderrHandler release];

	ECErrorPresenterHandler* errorPresenterHandler = [[ECErrorPresenterHandler alloc] init];
	[lm registerHandler: errorPresenterHandler];
	[errorPresenterHandler release];
}

// --------------------------------------------------------------------------
//! Open the main product website.
// --------------------------------------------------------------------------

- (IBAction) openWebsite: (id) sender
{
	NSString* urlString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"ECApplicationURL"];
	[[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString: urlString]];
}

// --------------------------------------------------------------------------
//! Open the online store for purchasing Neu
// --------------------------------------------------------------------------

- (IBAction) openStore: (id) sender;
{
	NSString* urlString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"ECApplicationStoreURL"];
	[[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString: urlString]];
}

// --------------------------------------------------------------------------
//! Open the product release notes.
// --------------------------------------------------------------------------

- (IBAction) openReleaseNotes: (id) sender
{
	NSString* format = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"ECApplicationReleaseNotesURL"];
	NSString* appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
	NSString* urlString = [NSString stringWithFormat: format, appVersion];
	[[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString: urlString]];	
}

// --------------------------------------------------------------------------
//! Open the product release notes.
// --------------------------------------------------------------------------

- (IBAction) openSupport: (id) sender
{
	NSString* urlString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"ECApplicationSupportURL"];
	[[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString: urlString]];
}

// --------------------------------------------------------------------------
//! Open the help page.
// --------------------------------------------------------------------------

- (IBAction) showHelp: (id) sender
{
	NSString* urlString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"ECApplicationHelpURL"];
	[[NSWorkspace sharedWorkspace] openURL: [NSURL URLWithString: urlString]];
}

// --------------------------------------------------------------------------
//! Display the preferences dialog.
// --------------------------------------------------------------------------

- (IBAction)showPreferences:(id)sender
{
    ECPreferencesController* prefs = [self getCachedPreferencesController];
	[NSApp activateIgnoringOtherApps:YES];
    [prefs showPreferencesWindow];
}

// --------------------------------------------------------------------------
//! Show the templates folder in the finder.
// --------------------------------------------------------------------------

- (IBAction) showAboutBox: (id) sender
{
	ECAboutBoxController* about = self.aboutController;
	if (!about)
	{
		about = [[ECAboutBoxController alloc] initWithWindowNibName: @"ECAboutBox"];
		self.aboutController = about;
		[about release];
	}
	
	[NSApp activateIgnoringOtherApps:YES];
	[about showAboutBox];
}


// --------------------------------------------------------------------------
//! Get the preferences controller - make it if necessary.
// --------------------------------------------------------------------------

- (ECPreferencesController*) getCachedPreferencesController
{
	ECPreferencesController* prefs = self.preferencesController;
    if (!prefs) 
	{
        // Determine path to the sample preference panes
        NSString *pathToPanes = [[NSString stringWithFormat:@"%@/Contents/PlugIns/", [[NSBundle mainBundle] bundlePath]] stringByStandardizingPath];
        
		prefs = [[ECPreferencesController alloc] initWithPanesSearchPath:pathToPanes];
        self.preferencesController = prefs;
		[prefs release];
        
        // Set which panes are included, and their order.
		NSArray* panes = [self getPreferencePanes];
		if (panes)
		{
			[prefs setPanesOrder: panes];
		}
    }
	
	return prefs;
}

// --------------------------------------------------------------------------
//! Return a list of the preference panes to display.
// --------------------------------------------------------------------------

- (NSArray*) getPreferencePanes
{       
    NSDictionary* info = [[NSBundle mainBundle] infoDictionary];
    NSArray* panes = [info objectForKey:@"ECPreferencePanes"];
    
    return panes;
}


#pragma mark -
#pragma mark ECAboutBoxInfoProvider methods

// --------------------------------------------------------------------------
//! Return information for use by the about box controller.
// --------------------------------------------------------------------------

- (NSString*) aboutBox:(ECAboutBoxController *)aboutBox getValueForKey:(NSString *)key
{
	NSString* value = nil;
	
	if ([key isEqualToString: @"status"])
	{
		value = [self.licenseChecker status];
	}
    
	return value;
}

#pragma mark -
#pragma mark Licensing

// --------------------------------------------------------------------------
//! Register the application.
// --------------------------------------------------------------------------

- (IBAction) openLicenseFile: (id) sender;
{
    [self.licenseChecker chooseLicenseFile];
}

#pragma mark -
#pragma mark Elegant Chaos Store Support

// --------------------------------------------------------------------------
//! Remove standard Elegant Chaos store menu items.
// --------------------------------------------------------------------------

- (void) stripElegantChaosStoreItemsFromMenu: (NSMenu*) menu
{
	NSMenuItem* item = [menu itemWithTag: 100];
	if (item)
	{
		[menu removeItem: item];
	}
	item = [menu itemWithTag: 101];
	if (item)
	{
		[menu removeItem: item];
	}
}

// --------------------------------------------------------------------------
//! Remove "Check For Updates" menu items.
// --------------------------------------------------------------------------

- (void) stripSparkleItemsFromMenu: (NSMenu*) menu
{
	NSMenuItem* item = [menu itemWithTag: 102];
	if (item)
	{
		[menu removeItem: item];
	}
}

#pragma mark -
#pragma mark Mac App Store Support

// --------------------------------------------------------------------------
//! Set things up for the Mac Store version of the app.
// --------------------------------------------------------------------------

- (BOOL) setupMacStore
{
	[self stripElegantChaosStoreItemsFromMenu:self.applicationMenu];
	[self stripSparkleItemsFromMenu:self.dockMenu];
	[self stripElegantChaosStoreItemsFromMenu:self.statusMenu];
	[self stripSparkleItemsFromMenu:self.applicationMenu];
	[self stripElegantChaosStoreItemsFromMenu:self.dockMenu];
	[self stripSparkleItemsFromMenu:self.statusMenu];
	
    ECCompoundLicenseChecker* compoundChecker = [[ECCompoundLicenseChecker alloc] init];
    
    ECMacStoreExact* exactChecker = [[ECMacStoreExact alloc] init];
    [compoundChecker addChecker: exactChecker];
    [exactChecker release];
    
#if CHECK_FOR_TEST_RECEIPT
    // look for saved MAS receipt with different version
    ECMacStoreDifferentVersion* differentVersionChecker = [[ECMacStoreDifferentVersion alloc] init];
    [compoundChecker addChecker: differentVersionChecker];
    [differentVersionChecker release];

    ECMacStoreTest* testChecker = [[ECMacStoreTest alloc] init];
    [compoundChecker addChecker: testChecker];
    [testChecker release];
#endif
    
	self.licenseChecker = compoundChecker;
	[compoundChecker release];
	
	return [compoundChecker isValid];
}

#pragma mark - User Guide


- (IBAction)showUserGuide:(id)sender
{
    NSError* error = nil;
    NSString* name = [NSString stringWithFormat:@"%@ User Guide", [[NSApplication sharedApplication] applicationName]];
    NSURL* docsPath = [self.fileManager URLForCachedDataPath:@"Documentation"];
    NSURL* localCopy = [[docsPath URLByAppendingPathComponent:name] URLByAppendingPathExtension:UserGuideType];
    NSURL* original = [[NSBundle mainBundle] URLForResource:name withExtension:UserGuideType];
    
    // does a local copy already exist?
    BOOL exists = [self.fileManager fileExistsAtURL:localCopy];
    if (exists)
    {
        // is it out of date?
        NSDictionary* localAttributes = [self.fileManager attributesOfItemAtPath:[localCopy path] error:&error];
        NSDictionary* originalAttributes = [self.fileManager attributesOfItemAtPath:[original path] error:&error];
        NSDate* localModified = [localAttributes objectForKey:NSFileModificationDate];
        NSDate* originalModified = [originalAttributes objectForKey:NSFileModificationDate];
        if (localModified && originalModified && [localModified isLessThan:originalModified])
        {
            // yes - remove old copy
            [self.fileManager removeItemAtURL:localCopy error:&error];
            exists = NO;
        }
    }
    
    // make a new copy if necessary
    if (!exists)
    {
        [self.fileManager copyItemAtURL:original toURL:localCopy error:&error];
    }
	
    // open the copy
    [[NSWorkspace sharedWorkspace] openURL:localCopy];
}

@end
