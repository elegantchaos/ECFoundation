// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 25/02/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Cocoa/Cocoa.h>

// --------------------------------------------------------------------------
//! Custom About Box controller.
// --------------------------------------------------------------------------

@interface ECAboutBoxController : NSWindowController 
{
	// --------------------------------------------------------------------------
	// Member Variables
	// --------------------------------------------------------------------------

	NSString*		mApplicationVersion;
	NSString*		mApplicationName;
	NSString*		mApplicationCopyright;
	NSString*		mApplicationStatus;
	NSURL*			mApplicationCreditsFile;
	NSTimeInterval	mAnimationDuration;
	BOOL			mAnimateFrame;
	BOOL			mClickToHide;
}

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

@property (retain, nonatomic) IBOutlet NSString*	applicationName;
@property (retain, nonatomic) IBOutlet NSString*	applicationVersion;
@property (retain, nonatomic) IBOutlet NSString*	applicationCopyright;
@property (retain, nonatomic) IBOutlet NSString*	applicationStatus;
@property (retain, nonatomic) IBOutlet NSURL*		applicationCreditsFile;

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (void) showAboutBox;
- (IBAction) alternatePerformClose: (id) sender;

@end
