// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 17/03/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "NSWorkspace+ECUtilities.h"
#import "NSAppleEventDescriptor+ECUtilities.h"

@implementation NSWorkspace(ECUtilities)

// --------------------------------------------------------------------------
//! Select an item pointed to by a URL.
// --------------------------------------------------------------------------

- (BOOL)selectURL:(NSURL*) fullPath inFileViewerRootedAtURL:(NSURL*) rootFullPath
{
	return [self selectFile: [fullPath path] inFileViewerRootedAtPath: [rootFullPath path]];
}

// --------------------------------------------------------------------------
//! Return whether the URL points at a file package.
// --------------------------------------------------------------------------

- (BOOL)isFilePackageAtURL: (NSURL*) fullPath
{
	return [self isFilePackageAtPath: [fullPath path]];
}

// --------------------------------------------------------------------------
//! Return the icon to use for the item at a URL.
// --------------------------------------------------------------------------

- (NSImage*)	iconForURL:(NSURL*) fullPath
{
	return [self iconForFile: [fullPath path]];
}

// --------------------------------------------------------------------------
//! Return the path of the front Finder window.
//! Returns nil if no windows are open.
//! TODO - should move the script into the framework and not compile it every time
// --------------------------------------------------------------------------

- (NSURL*) urlOfFrontWindow
{
	NSURL* url = nil;
	NSString* const kScript = @""
	"tell application \"Finder\" \n"
	"	if the number of windows > 0 then \n"
	"		set p to POSIX path of ((target of first window) as alias) \n"
	"	else \n"
	"		set p to POSIX path of (desktop as alias) \n"
	"	end if \n"
	"end tell";
	
	NSDictionary* error = nil;
	NSAppleScript * script = [[NSAppleScript alloc] initWithSource: kScript];
	NSAppleEventDescriptor* result = [script executeAndReturnError: &error];
	if (result)
	{
		url = [NSURL fileURLWithPath: [result stringValue] isDirectory: YES];
	}
	[script release];

	return url;
}


// --------------------------------------------------------------------------
//! Return the path to the selected item in the finder.
//! Returns nil if no windows are open.
//! TODO - should move the script into the framework and not compile it every time
// --------------------------------------------------------------------------

- (NSArray*) urlsOfSelection
{

	NSString* const kScript = @""
	"tell application \"Finder\" \n"
	"	set r to {} \n"
	"	repeat with i in (the selection as list) \n"
	"		set r to r & {POSIX path of (i as alias)} \n"
	"	end repeat \n"
	"	return r \n"
	"end tell";
	
	NSArray* urls = nil;
	NSDictionary* error = nil;
	NSAppleScript * script = [[NSAppleScript alloc] initWithSource: kScript];
	NSAppleEventDescriptor* result = [script executeAndReturnError: &error];
	if (result)
	{
		urls = [result urlArrayValue];
	}
	[script release];
	
	return urls;
}


- (void)enableLoginItemWithURL:(NSURL *)itemURL
{
	LSSharedFileListRef loginListRef = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
	
	if (loginListRef) {
		// Insert the item at the bottom of Login Items list.
		LSSharedFileListItemRef loginItemRef = LSSharedFileListInsertItemURL(loginListRef, 
																			 kLSSharedFileListItemLast, 
																			 NULL, 
																			 NULL,
																			 (CFURLRef)itemURL, 
																			 NULL, 
																			 NULL);             
		if (loginItemRef) {
			CFRelease(loginItemRef);
		}
		CFRelease(loginListRef);
	}
}

@end
