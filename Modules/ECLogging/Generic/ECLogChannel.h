// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECLogContext.h"

@class ECLogHandler;

@interface ECLogChannel : NSObject
{
@private
	BOOL enabled;
	BOOL setup;
	NSString* name;
	NSMutableSet* handlers;
    ECLogContextFlags context;
}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

@property (nonatomic, assign) ECLogContextFlags context;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) BOOL setup;
@property (nonatomic, assign) NSInteger level;
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
- (BOOL) showContext:(ECLogContextFlags)flags;
- (NSString*) fileFromContext:(ECLogContext*)context;
- (NSString*) stringFromContext:(ECLogContext*)context;
- (BOOL)tickFlagWithIndex:(NSUInteger)index;
- (void)selectFlagWithIndex:(NSUInteger)index;
- (BOOL)tickHandlerWithIndex:(NSUInteger)index;
- (void)selectHandlerWithIndex:(NSUInteger)index;
+ (NSString*) cleanName:(const char *) name;

@end

