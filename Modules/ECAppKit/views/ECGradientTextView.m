//
//  ECGradientTextView.m
//  ambientweet
//
//  Created by Sam Deane on 10/04/2012.
//  Copyright (c) 2012 Elegant Chaos. All rights reserved.
//

#import "ECGradientTextView.h"

@interface ECGradientTextView()

@property (assign, nonatomic) NSRect lastRect;
@property (strong, nonatomic) NSBezierPath* path;

- (void)setupDefaults;

@end

@implementation ECGradientTextView

static const CGFloat kStartAlpha = 0.8;
static const CGFloat kEndAlpha = 0.65;
static const CGFloat kDefaultRadius = 25.0;

@synthesize lastRect = _lastRect;
@synthesize path = _path;
@synthesize gradient = _gradient;
@synthesize radius = _radius;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        self.drawsBackground = YES;
        [self setupDefaults];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [self setupDefaults];
}

- (void)dealloc
{
    [_gradient release];
    [_path release];
    
    [super dealloc];
}

- (void) setupDefaults
{
	self.radius = kDefaultRadius;
	NSColor* start = [NSColor colorWithCalibratedWhite:0.0f alpha:kStartAlpha];
	NSColor* end = [start colorWithAlphaComponent:kEndAlpha];
	self.gradient = [[[NSGradient alloc] initWithStartingColor:start endingColor:end] autorelease];
}

- (void)drawViewBackgroundInRect:(NSRect)rect
{
    if (!NSEqualRects(self.lastRect, rect))
    {
        self.path = [NSBezierPath bezierPathWithRoundedRect:rect xRadius:self.radius yRadius:self.radius];
    }

    [self.gradient drawInBezierPath:self.path angle:90.0];
}

@end
