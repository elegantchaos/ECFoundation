// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/08/2011.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <AppKit/AppKit.h>

@interface ECCompletionTextView : NSTextView

{
@private
    NSCharacterSet* triggers;
    NSArray* potentialCompletions;
    NSTimer* completionTimer;
    NSCharacterSet* whitespace;
    NSUInteger nextInsertionIndex;
}

@property (nonatomic, retain) NSCharacterSet* triggers;
@property (nonatomic, retain) NSArray* potentialCompletions;

@end
