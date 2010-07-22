// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 21/07/2010.
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <UIKit/UIKit.h>


@interface ECNavigationController : UINavigationController
{
	UIViewController* mInitialView;
}

@property (retain, nonatomic) IBOutlet UIViewController* initialView;

+ (ECNavigationController*) currentController;

@end
