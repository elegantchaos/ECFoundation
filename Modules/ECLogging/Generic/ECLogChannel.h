// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@class ECLogHandler;

@interface ECLogChannel : NSObject
{
@private
	BOOL enabled;
	BOOL setup;
	NSString* name;
	NSMutableSet* handlers;
}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) BOOL setup;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSMutableSet* handlers;

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (void) enable;
- (void) disable;
- (id) initWithName: (NSString*) name;
- (NSComparisonResult) caseInsensitiveCompare: (ECLogChannel*) other;
- (void) enableHandler: (ECLogHandler*) handler;
- (void) disableHandler: (ECLogHandler*) handler;
- (BOOL) isHandlerEnabled:( ECLogHandler*) handler;

+ (NSString*) cleanName:(const char *) name;

@end

