// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 08/09/2010
//
//! @file Additional methods for the NSApplication class.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "NSApplication+ECCore.h"
#import "ECLaunchServices.h"

#import "NSBundle+ECCore.h"

@implementation NSApplication(ECCore)


ECDefineDebugChannel(NSApplicationChannel);

// --------------------------------------------------------------------------
//! Bring this process to the front.
// --------------------------------------------------------------------------

- (void)bringToFront
{
	ProcessSerialNumber psn = { 0, kCurrentProcess };
	SetFrontProcess(&psn);
}

// --------------------------------------------------------------------------
//! Bring the next process to the front.
// --------------------------------------------------------------------------

- (void)bringNextProcessToFront
{
	ProcessSerialNumber psnx = { 0, kNoProcess };
	GetNextProcess(&psnx);
	SetFrontProcess(&psnx);
}

// --------------------------------------------------------------------------
//! Bring another process to the front.
//! We try to avoid the login process, which seems to stay running on Lion,
//! since bringing it to the front seems to force the user to enter their
//! password again.
// --------------------------------------------------------------------------

- (void)bringAnotherProcessToFront
{
	ProcessSerialNumber psnx = { 0, kNoProcess };
    OSErr result = noErr;
    while (result == noErr)
    {
        
        result = GetNextProcess(&psnx);
        if (result == noErr)
        {
            if (IsProcessVisible(&psnx))
            {
                ProcessInfoRec info;
                memset(&info, 0, sizeof(info));
                info.processInfoLength = sizeof(info);
                result = GetProcessInformation(&psnx, &info);
                if (result == noErr)
                {
                    if ((info.processType == 'APPL') && (info.processSignature != 'lgnw'))
                    {
                        SetFrontProcess(&psnx);
                        break;
                    }
                }
            }
        }
        
    }
}

// --------------------------------------------------------------------------
//! Control whether this process shows up in the dock.
// --------------------------------------------------------------------------

- (void)setShowsDockIcon: (BOOL)flag 
{
	NSApplicationActivationPolicy currentPolicy = [NSApp activationPolicy];
	if (flag && (currentPolicy == NSApplicationActivationPolicyAccessory)) 
	{
		ECDebug(NSApplicationChannel, @"enabling dock icon");
		[NSApp setActivationPolicy: NSApplicationActivationPolicyRegular];
		[self bringAnotherProcessToFront];
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

// --------------------------------------------------------------------------
//! Return the bundle identifier of the application.
// --------------------------------------------------------------------------

- (NSString*) applicationID
{
    NSString* result = [[NSBundle mainBundle] bundleIdentifier];

    return result;
}


// --------------------------------------------------------------------------
//! Return the bundle name of the application.
// --------------------------------------------------------------------------

- (NSString*) applicationName
{
    NSString* result = [[NSBundle mainBundle] bundleName];

    return result;
}

// --------------------------------------------------------------------------
//! Return the user readable application version (e.g. 1.2).
// --------------------------------------------------------------------------

- (NSString*) applicationVersion
{
    NSString* result = [[NSBundle mainBundle] bundleVersion];
    
    return result;
}

// --------------------------------------------------------------------------
//! Return the real application version (typically a build number, like 1535).
// --------------------------------------------------------------------------

- (NSString*) applicationBuild
{
    NSString* result = [[NSBundle mainBundle] bundleBuild];
    
    return result;
}

// --------------------------------------------------------------------------
//! Return a string showing the application version, with the build number,
//! eg "Version 1.0b2 (343)"
// --------------------------------------------------------------------------

- (NSString*) applicationFullVersion
{
    NSString* result = [[NSBundle mainBundle] bundleFullVersion];
    
    return result;
}

// --------------------------------------------------------------------------
//! Return the user readable copyright notice for the application.
// --------------------------------------------------------------------------

- (NSString*) applicationCopyright
{
    NSString* result = [[NSBundle mainBundle] bundleCopyright];
    
    return result;
}

// --------------------------------------------------------------------------
//! Return the file type of this application's license files.
// --------------------------------------------------------------------------

- (NSString*) licenseFileType
{
    NSDictionary* info = [[NSBundle mainBundle] infoDictionary];
    NSString* licenseFileType = [info objectForKey:@"ECLicenseFileType"];
    
    return licenseFileType;
}

@end
