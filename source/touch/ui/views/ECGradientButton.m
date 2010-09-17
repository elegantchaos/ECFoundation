//
//  GradientView.m
//  pod point
//
//  Created by Sam Deane on 02/09/2010.
//  Copyright 2010 Elegant Chaos. All rights reserved.
//

#import "ECGradientButton.h"

#import <QuartzCore/QuartzCore.h>

@implementation ECGradientButton

ECPropertySynthesize(topColour);
ECPropertySynthesize(bottomColour);
ECPropertySynthesize(gradient);

- (void) addCAGradient
{
	self.topColour = [UIColor colorWithRed: 0.53 green: 0.53 blue: 0.53 alpha: 1.0];
	self.bottomColour = [UIColor colorWithRed: 0.64 green: 0.64 blue: 0.64 alpha: 1.0];
	
	CAGradientLayer* gradient = [CAGradientLayer layer];
    [gradient setBounds:[self bounds]];
    [gradient setPosition: CGPointMake([self bounds].size.width/2, [self bounds].size.height/2)];
	gradient.frame = self.bounds;
	[self.layer insertSublayer:gradient atIndex:0];
    [[self layer] setCornerRadius:8.0f];
    [[self layer] setMasksToBounds:YES];
    [[self layer] setBorderWidth:1.0f];
    [[self layer] setBorderColor: [self.topColour CGColor]];
	self.gradient = gradient;
	[self updateColours];
}

- (void) updateColours
{
	self.gradient.colors = [NSArray arrayWithObjects:(id) [self.topColour CGColor], (id) [self.bottomColour CGColor], nil];
}

- (id) initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame: frame]) != nil)
	{
		[self addCAGradient];
	}
	
	return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder: aDecoder]) != nil)
	{
		[self addCAGradient];
	}
	
	return self;
}

- (void) dealloc
{
	ECPropertyDealloc(gradient);
	
	[super dealloc];
}
@end
