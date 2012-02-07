//
//  ECPopoverController.h
//  AllenOvery
//
//  Created by Sam Deane on 07/02/2012.
//  Copyright (c) 2012 Toolbox Design Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSingleton.h"

@interface ECPopoverController : NSObject<UIPopoverControllerDelegate>

EC_SINGLETON(ECPopoverController);

- (BOOL)isShowingPopover;
- (void)dismissPopover;
- (void)presentPopoverWithContentClass:(NSString*)name fromBarButtonItem:(UIBarButtonItem *)item permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated;
- (void)presentPopoverWithContentClass:(NSString*)name fromRect:(CGRect)rect inView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated;

@end
