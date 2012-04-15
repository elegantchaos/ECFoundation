// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 13/03/2011
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECLicenseChecker.h"

#import "NSApplication+ECCore.h"

@implementation ECLicenseChecker

- (BOOL) isValid
{
    return NO;
}

- (NSDictionary*) info
{
    return nil;
}

- (NSString*) user
{
    return nil;
}

- (NSString*) email
{
    return nil;
}

- (NSString*) status
{
    return @"Trial Version - Unregistered";
}

- (BOOL) importLicenseFromURL: (NSURL*) url
{
    return NO;
}

// --------------------------------------------------------------------------
//! Register a given license file.
// --------------------------------------------------------------------------

- (void) registerLicenseFile: (NSURL*) licenseURL
{
	NSString* appName = [[NSApplication sharedApplication] applicationName];
	BOOL ok = [self importLicenseFromURL: licenseURL];
	NSAlert* alert;
	if (ok)
	{
		alert = [NSAlert alertWithMessageText: @"License Valid" defaultButton: @"OK" alternateButton: nil otherButton: nil informativeTextWithFormat: @"Thank you for registering %@.\n\nThis copy is now licensed to %@ (%@)", appName, self.user, self.email];
	}
	else
	{
		alert = [NSAlert alertWithMessageText: @"License Invalid" defaultButton: @"OK" alternateButton: nil otherButton: nil informativeTextWithFormat: @"The license file that you selected was not valid for %@.", appName];
	}
	[alert runModal];
	
}

// --------------------------------------------------------------------------
//! Register the application.
// --------------------------------------------------------------------------

- (void) chooseLicenseFile;
{
	NSString* appName = [[NSApplication sharedApplication] applicationName];
	NSDictionary* info = [[NSBundle mainBundle] infoDictionary];
    NSString* licenseFileType = [info objectForKey:@"ECLicenseFileType"];
    
	NSOpenPanel* panel = [NSOpenPanel openPanel];
    panel.title = @"Use License File";
    panel.message = [NSString stringWithFormat: @"Select the license file that you wish to use with %@.\nTypically you will have been sent a link to this file as part of the registration process.", appName];
    panel.prompt = @"Use License";
	[panel setAllowedFileTypes: [NSArray arrayWithObject: licenseFileType]];
	[panel setCanSelectHiddenExtension: YES];
	[panel beginWithCompletionHandler:
	 ^(NSInteger result)
	 {
		 if (result == NSFileHandlingPanelOKButton)
		 {
			 NSURL* licenseURL = [panel.URLs objectAtIndex: 0];
			 [self registerLicenseFile: licenseURL];
		 }
	 }];
}


@end
