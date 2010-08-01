// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 21/07/2010.
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <UIKit/UIKit.h>

@class ECDataItem;

@interface ECNavigationController : UINavigationController
{
	UIViewController* mInitialView;
}

@property (retain, nonatomic) IBOutlet UIViewController* initialView;

+ (ECNavigationController*) currentController;

- (BOOL) openSubviewForItem: (ECDataItem*) item;
- (BOOL) openViewerForItem: (ECDataItem*) item;
- (BOOL) openEditorForItem: (ECDataItem*) item;
- (BOOL) openViewForItem: (ECDataItem*) item classKey: (NSString*) classKey nibKey: (NSString*) nibKey;

@end
