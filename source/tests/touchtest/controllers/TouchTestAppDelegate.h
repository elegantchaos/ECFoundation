/// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 01/08/2010
//
//  Copyright 2010 sam, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------


#import <UIKit/UIKit.h>

@class ECDataItem;

@interface TouchTestAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> 
{
	UIWindow*				window;
	UITabBarController*		tabBarController;

	ECPropertyDefineVariable(name, ECDataItem*);
	ECPropertyDefineVariable(password, ECDataItem*);
}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

@property (nonatomic, retain) IBOutlet UIWindow*			window;
@property (nonatomic, retain) IBOutlet UITabBarController*	tabBarController;

ECPropertyRetained(name, ECDataItem*);
ECPropertyRetained(password, ECDataItem*);

@end

