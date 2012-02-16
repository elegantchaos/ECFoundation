//
//  ECPopoverController.h
//  AllenOvery
//
//  Created by Sam Deane on 07/02/2012.
//  Copyright (c) 2012 Toolbox Design Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSingleton.h"

@interface ECTPopoverController : NSObject<UIPopoverControllerDelegate>

EC_SINGLETON(ECTPopoverController);

- (BOOL)isShowingPopover;
- (void)dismissPopover;
- (void)presentPopoverWithContentClass:(NSString*)name content:(id)content fromBarButtonItem:(UIBarButtonItem *)item permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated;
- (void)presentPopoverWithContentClass:(NSString*)name content:(id)content fromRect:(CGRect)rect inView:(UIView *)view permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections animated:(BOOL)animated;

@end
