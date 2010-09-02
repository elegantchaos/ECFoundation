// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 25/02/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
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

@end

// --------------------------------------------------------------------------
//! Application Info Provider Protocol
//!
//! The application delegate should implement this to provide
//! extra information to the about box.
// --------------------------------------------------------------------------

@protocol ECAboutBoxInfoProvider
	- (NSString*) aboutBox: (ECAboutBoxController*) aboutBox getValueForKey: (NSString*) key;
@end
