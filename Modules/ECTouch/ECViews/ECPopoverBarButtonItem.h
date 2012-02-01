//
//  ECPopoverBarButtonItem.h
//  AllenOvery
//
//  Created by Sam Deane on 01/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECPopoverBarButtonItem : UIBarButtonItem<UIPopoverControllerDelegate>

- (id)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style content:(NSString*)contentIn;

@end
