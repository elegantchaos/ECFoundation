// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 25/02/2010
//
// Borrowed from sample code by Matt Gemmell, who appears to have borrowed
// it in turn from Tony Arnold.
//
// See http://codesorcery.net/2008/02/06/feature-requests-versus-the-right-way-to-do-it
// for more information.
// --------------------------------------------------------------------------

#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>

@implementation NSApplication (DockIcon)

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

- (void)setShowsDockIcon:(BOOL)flag 
{
	NSApplicationActivationPolicy currentPolicy = [NSApp activationPolicy];
	if (flag && (currentPolicy == NSApplicationActivationPolicyAccessory)) 
	{
		ECDebug(@"enabling dock icon");
		[NSApp setActivationPolicy: NSApplicationActivationPolicyRegular];
		[self bringNextProcessToFront];
		[self performSelector:@selector(bringToFront) withObject:nil afterDelay:0.0];
	} 
	
	else if (!flag && (currentPolicy == NSApplicationActivationPolicyRegular))
	{
		ECDebug(@"disabling dock icon");
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


@end
