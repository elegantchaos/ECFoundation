// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 25/02/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECAboutBoxController.h"

// --------------------------------------------------------------------------
// Private Interface
// --------------------------------------------------------------------------

@interface ECAboutBoxController()

- (void) setupDefaults;
- (void) setupFromBundleInfo: (NSBundle*) bundle;

@end

// --------------------------------------------------------------------------
// Implementation
// --------------------------------------------------------------------------

@implementation ECAboutBoxController

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

@synthesize applicationName = mApplicationName;
@synthesize applicationVersion = mApplicationVersion;
@synthesize applicationCopyright = mApplicationCopyright;
@synthesize applicationCreditsFile = mApplicationCreditsFile;

// --------------------------------------------------------------------------
//! Clean up
// --------------------------------------------------------------------------

- (void) dealloc
{
	[mApplicationName release];
	[mApplicationVersion release];
	[mApplicationCopyright release];
	[mApplicationCreditsFile release];
	
	[super dealloc];
}

// --------------------------------------------------------------------------
//! Set things up after the nib has loaded.
// --------------------------------------------------------------------------

- (void) windowDidLoad
{
	[self setupDefaults];
	
	NSBundle *mainBundle = [NSBundle mainBundle];
	[self setupFromBundleInfo: mainBundle];
	
	NSURL* mainURL = [mainBundle bundleURL];
	if (mainURL)
	{
		self.applicationCreditsFile = [mainURL URLByAppendingPathComponent: @"Contents/Resources/English.lproj/Credits.rtf"];
	}
	
	if (mClickToHide)
	{
		NSWindow* window = [self window];
		NSButton* closeButton = [window standardWindowButton: NSWindowCloseButton];
		[closeButton setEnabled: NO];
	}
}

// --------------------------------------------------------------------------
//! Initialse properties to default values.
// --------------------------------------------------------------------------

- (void) setupDefaults
{
	mClickToHide = FALSE;
	mAnimationDuration = 0.25f;
	mAnimateFrame = YES;
}

- (void) setBoolIfPresent: (BOOL*) valueOut withKey: (NSString*) key fromDictionary: (NSDictionary*) dictionary
{
	id value = [dictionary valueForKey: key];
	if (value)
	{
		*valueOut = [value boolValue];
	}
}

- (void) setDoubleIfPresent: (double*) valueOut withKey: (NSString*) key fromDictionary: (NSDictionary*) dictionary
{
	id value = [dictionary valueForKey: key];
	if (value)
	{
		*valueOut = [value doubleValue];
	}
}

// --------------------------------------------------------------------------
//! Initialise properties using a bundle's info dictionary.
// --------------------------------------------------------------------------

- (void) setupFromBundleInfo: (NSBundle*) bundle
{
	NSDictionary *infoDict = [bundle infoDictionary];
	
    NSString *mainString = [infoDict valueForKey:@"CFBundleShortVersionString"];
    NSString *subString = [infoDict valueForKey:@"CFBundleVersion"];
	
    self.applicationVersion = [NSString stringWithFormat:@"Version %@ (%@)", mainString, subString];
	self.applicationCopyright = [infoDict valueForKey:@"NSHumanReadableCopyright"];
	self.applicationName = [infoDict valueForKey:@"CFBundleName"];
	
	[self setBoolIfPresent: &mClickToHide withKey: @"ECAboutBoxClickToHide" fromDictionary: infoDict];
	[self setBoolIfPresent: &mAnimateFrame withKey: @"ECAboutBoxAnimateFrame" fromDictionary: infoDict];
	[self setDoubleIfPresent: &mAnimationDuration withKey: @"ECAboutBoxAnimationDuration" fromDictionary: infoDict];
}

// --------------------------------------------------------------------------
//! Animate in the about box.
// --------------------------------------------------------------------------

- (void) showAboutBox
{
	NSWindow* window = [self window];
	[window center];
	NSRect destFrame = [window frame];
	NSRect startFrame;
	startFrame.size = NSZeroSize;
	startFrame.origin = NSMakePoint(NSMidX(destFrame), NSMidY(destFrame));
	if (mAnimateFrame)
	{
		[window setFrame:startFrame display: NO];
	}
	[window setAlphaValue: 0.0f];
	[window makeKeyAndOrderFront: self];
	
	[NSAnimationContext beginGrouping];
	[[NSAnimationContext currentContext] setDuration:mAnimationDuration];
	if (mAnimateFrame)
	{
		[[window animator] setFrame:destFrame display:YES];
	}
	[[window animator] setAlphaValue:1.0f];
	[NSAnimationContext endGrouping];	
}

// --------------------------------------------------------------------------
//! Animate out the about box.
// --------------------------------------------------------------------------

- (void) hideAboutBox
{
	NSWindow* window = [self window];

	[NSAnimationContext beginGrouping];
	[[NSAnimationContext currentContext] setDuration:mAnimationDuration];
	//[[window animator] setFrame:destFrame display:YES];
	[[window animator] setAlphaValue:0.0f];
	[NSAnimationContext endGrouping];	
	
	[self performSelector: @selector(close) withObject: nil afterDelay: mAnimationDuration]; 
}

// --------------------------------------------------------------------------
//! Should the window close?
//! When this is called, we return no, but trigger our close animation
//! which will ultimately result in it closing.
// --------------------------------------------------------------------------

- (BOOL) windowShouldClose: (id) sender
{
	[self hideAboutBox];

	return FALSE;
}

// --------------------------------------------------------------------------
//! Handle a mouse down anywhere in the window to close it.
//! We only do this if the mClickToHide property is true.
// --------------------------------------------------------------------------

- (void) mouseDown:(NSEvent*) evt
{
	if (mClickToHide)
	{
		[self hideAboutBox];
	}
}

@end
