// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 08/09/2010
//
//! @file Additional methods for the NSApplication class.
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "NSApplication+ECUtilities.h"
#import "ECLaunchServices.h"

@implementation NSApplication(ECUtilities)


ECDefineDebugChannel(NSApplicationChannel);

-(void) bringToFront
{
	ProcessSerialNumber psn = { 0, kCurrentProcess };
	SetFrontProcess(&psn);
}

- (void) bringNextProcessToFront
{
	ProcessSerialNumber psnx = { 0, kNoProcess };
	GetNextProcess(&psnx);
	SetFrontProcess(&psnx);
}

- (void)setShowsDockIcon: (BOOL)flag 
{
	NSApplicationActivationPolicy currentPolicy = [NSApp activationPolicy];
	if (flag && (currentPolicy == NSApplicationActivationPolicyAccessory)) 
	{
		ECDebug(NSApplicationChannel, @"enabling dock icon");
		[NSApp setActivationPolicy: NSApplicationActivationPolicyRegular];
		[self bringNextProcessToFront];
		[self performSelector:@selector(bringToFront) withObject:nil afterDelay:0.1];
	} 
	
	else if (!flag && (currentPolicy == NSApplicationActivationPolicyRegular))
	{
		ECDebug(NSApplicationChannel, @"disabling dock icon");
		NSAlert *alert = [[[NSAlert alloc] init] autorelease];
		[alert addButtonWithTitle:@"Relaunch Now"];
		[alert addButtonWithTitle:@"Later"];
		NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
		NSString *appName = [[NSFileManager defaultManager] displayNameAtPath: bundlePath];
		[alert setMessageText:[NSString stringWithFormat:@"You must now restart %@", appName]];
		[alert setInformativeText:@"Your new setting for the Dock icon won't show up until you relaunch this application."];
		[alert setAlertStyle:NSWarningAlertStyle];
		NSInteger result = [alert runModal];
		if (result == NSAlertFirstButtonReturn) 
		{
			[NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:[NSArray arrayWithObjects:@"-c", [NSString stringWithFormat:@"sleep 1 ; /usr/bin/open '%@'", [[NSBundle mainBundle] bundlePath]], nil]];
			[NSApp terminate:self];
		}
	}
}

// --------------------------------------------------------------------------
//! Return the URL for the application.
// --------------------------------------------------------------------------

- (NSURL*) applicationURL
{
    NSURL* applicationURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];

	return applicationURL;
}

// --------------------------------------------------------------------------
//! Return whether or not the application is set to start at login.
// --------------------------------------------------------------------------

- (BOOL) willStartAtLogin
{
    return [ECLaunchServices willOpenAtLogin: [self applicationURL]];
}

// --------------------------------------------------------------------------
//! Set whether or not the application will start at login.
// --------------------------------------------------------------------------

- (void) setWillStartAtLogin: (BOOL) enabled
{
	[self willChangeValueForKey:@"willStartAtLogin"];
    [ECLaunchServices setOpenAtLogin:[self applicationURL] enabled: enabled];
    [self didChangeValueForKey:@"willStartAtLogin"];
}

@end
