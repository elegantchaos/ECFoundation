// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/11/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@class ECLogManager;

@interface ECLoggingMenu : NSMenu 
{
    ECLogManager* mLogManager;
}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (IBAction) channelSelected: (id) sender;
- (IBAction) enableAllSelected: (id) sender;
- (IBAction) disableAllSelected: (id) sender;

@end
