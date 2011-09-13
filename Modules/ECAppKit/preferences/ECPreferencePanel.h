// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 07/03/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECPreferencePaneProtocol.h"

@interface ECPreferencePanel : NSObject <ECPreferencePaneProtocol> 
{
    IBOutlet NSView *prefsView;
}

- (void) paneDidLoad;

@end
