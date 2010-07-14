// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 07/03/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECPreferencePaneProtocol.h"

@interface ECPreferencePanel : NSObject <ECPreferencePaneProtocol> 
{
    IBOutlet NSView *prefsView;
}

- (void) paneDidLoad;

@end
