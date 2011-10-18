// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 05/07/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECScrollView.h"

#pragma mark - Constants


@implementation ECScrollView

#pragma mark - Channels

ECDefineDebugChannel(ECScrollViewChannel);

#pragma mark - Properties

@synthesize action;
@synthesize swallowTouches;
@synthesize target;

-(void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{	
    if (!self.dragging)
    {
        // drop the touchesEnded call through to the responder chain?
        if (!self.swallowTouches)
        {
            [self.nextResponder touchesEnded: touches withEvent:event]; 
        }		
        
        // perform custom action?
        if (self.target && self.action)
        {
            [self.target performSelector:self.action withObject:event];
        }
    }
    
	[super touchesEnded: touches withEvent: event];
}

@end
