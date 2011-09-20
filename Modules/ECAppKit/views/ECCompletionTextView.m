// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/08/2011.
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECCompletionTextView.h"
#import "ECLogging.h"

@interface ECCompletionTextView()

@property (nonatomic, retain) NSTimer* completionTimer;
@property (nonatomic, retain) NSCharacterSet* whitespace;
@property (nonatomic, assign) NSUInteger nextInsertionIndex;

- (void)setupWhitespace;

@end

@implementation ECCompletionTextView

// ==============================================
// Constants
// ==============================================

#pragma mark - Constants

static NSTimeInterval kCompletionDelay = 0.5;

#pragma mark - Properties

@synthesize completionTimer;
@synthesize nextInsertionIndex;
@synthesize potentialCompletions;
@synthesize triggers;
@synthesize whitespace;

#pragma mark - Channels

ECDefineDebugChannel(CompletionTextViewChannel);

- (void)awakeFromNib
{
    [self setupWhitespace];
    [super awakeFromNib];
}

- (id)initWithFrame:(NSRect)frameRect textContainer:(NSTextContainer *)container
{
    if ((self = [super initWithFrame:frameRect textContainer:container]) != nil)
    {
        [self setupWhitespace];
    }
    
    return self;
}

- (void)dealloc 
{
    [potentialCompletions release];
    [triggers release];
    [whitespace release];
    
    [super dealloc];
}

- (void)setupWhitespace
{
    self.whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
}

// ==============================================
// NSTextViewDelegate
// ==============================================

#pragma mark -
#pragma mark NSTextViewDelegate

- (void)doCompletion:(NSTimer*)timer 
{
    [self complete:nil];
    
    [timer invalidate];
    self.completionTimer = nil;
}

- (void)startCompletionTimer;
{
    [self.completionTimer invalidate];
    self.completionTimer = [NSTimer scheduledTimerWithTimeInterval:kCompletionDelay target:self selector:@selector(doCompletion:) userInfo:nil repeats:NO];
}

- (void)stopCompletionTimer 
{
    [self.completionTimer invalidate];
    self.completionTimer = nil;
}

- (BOOL)shouldChangeTextInRange: (NSRange)affectedCharRange replacementString:(NSString *) replacementString 
{
    NSRange completionRange = [self rangeForUserCompletion];
    
    ECDebug(CompletionTextViewChannel, @"should change %@ in range %@ '%@'", replacementString, NSStringFromRange(affectedCharRange), [[self string] substringWithRange:affectedCharRange]);
    ECDebug(CompletionTextViewChannel, @"completionRange is %@", NSStringFromRange(completionRange));
    
    BOOL autoComplete = NO;
    NSString* completionString;
    if (completionRange.location != NSNotFound)
    {
        completionString = [[self string] substringWithRange:completionRange];
    }
    else 
    {
        completionString = replacementString;
    }
    autoComplete = (([completionString length] > 0) && ([self.triggers characterIsMember:[completionString characterAtIndex:0]]));
    
    if (autoComplete)
    {
        self.nextInsertionIndex = affectedCharRange.location + [replacementString length];
        [self startCompletionTimer];
    }
    else
    {
        [self stopCompletionTimer];
        self.nextInsertionIndex = NSNotFound;
    }
    
    return YES;
}

- (NSRange)willChangeSelectionFromCharacterRange:(NSRange)oldSelectedCharRange toCharacterRange:(NSRange)newSelectedCharRange 
{
    ECDebug(CompletionTextViewChannel, @"will change from %@ to %@", NSStringFromRange(oldSelectedCharRange), NSStringFromRange(newSelectedCharRange));
    /* Stop the timer on selection changes other than those caused by the typing that started the timer. */
    if (newSelectedCharRange.length > 0 || newSelectedCharRange.location != self.nextInsertionIndex)
    {
        [self stopCompletionTimer];
    }
    
    return newSelectedCharRange;
}

- (NSRange)rangeForUserCompletion
{
    NSRange result = NSMakeRange(NSNotFound, 0);
    NSRange selection = self.selectedRange;
    NSString* fullText = [self string];
    NSCharacterSet* ws = self.whitespace;
    NSCharacterSet* tr = self.triggers;
    
    if (selection.location > 0)
    {
        NSUInteger n = selection.location;
        while (n--)
        {
            unichar c = [fullText characterAtIndex:n];
            if ([tr characterIsMember:c])
            {
                result.length = selection.location - n;
                result.location = n;
                break;
            }
            else if ([ws characterIsMember:c])
            {
                break;
            }
        }

        ECDebug(CompletionTextViewChannel, @"range is %@ %@", NSStringFromRange(result), result.location == NSNotFound ? @"(not found)" : [fullText substringWithRange:result]);
    }
    
    return result;
}

- (NSArray *)completionsForPartialWordRange:(NSRange)charRange indexOfSelectedItem:(NSInteger *)index
{
    NSString* fullText = [self string];
    NSString* string = [fullText substringWithRange:charRange];
    ECDebug(CompletionTextViewChannel, @"completions for '%@' (%@)", string, NSStringFromRange(charRange));
    
    NSMutableArray* result = [NSMutableArray array];
    NSRange startRange = NSMakeRange(0, string.length);
    for (NSString* item in self.potentialCompletions)
    {
        if (([item length] >= startRange.length) && ([[item substringWithRange:startRange] isEqualToString:string]))
        {
            [result addObject:item];
        }
    }
    
    if ([result count] == 0)
    {
        result = nil;
    }
    
    return result;
}

@end
