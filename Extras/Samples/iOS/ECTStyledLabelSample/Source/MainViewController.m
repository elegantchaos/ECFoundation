//
//  MainViewController.m
//  ECStyledLabelSample
//
//  Created by Sam Deane on 28/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

#import "ECDebugViewController.h"
#import "ECDebugViewPopoverController.h"
#import "ECMarkdownParser.h"

#import "ECTPopoverBarButtonItem.h"
#import "ECTStyledLabel.h"

@interface MainViewController()

- (void)updateStyledText;

@end

@implementation MainViewController

#pragma mark - Properties

@synthesize labelStyled;
@synthesize labelScrolling;
@synthesize labelTappable;
@synthesize textViewMarkdown;

- (void)dealloc 
{
    [labelScrolling release];
    [labelStyled release];
    [labelTappable release];
    [textViewMarkdown release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem* debugButton = [[ECTPopoverBarButtonItem alloc] initWithTitle:@"Debug" style:UIBarButtonItemStylePlain content:@"ECDebugViewPopoverController"];
    self.navigationItem.rightBarButtonItem = debugButton;
    [debugButton release];
    
    self.title = @"ECStyledLabel Test Bed";
}

- (void)viewDidUnload
{
    self.labelStyled = nil;
    self.labelScrolling = nil;
    self.labelTappable = nil;
    self.textViewMarkdown = nil;
    
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateStyledText];
}

- (void)updateStyledText
{
    NSString* markdown = self.textViewMarkdown.text;
    ECDocumentStyles* styles = [self.labelStyled defaultStyles];
    ECMarkdownParser* parser = [[ECMarkdownParser alloc] initWithStyles:styles];
    NSAttributedString* text = [parser attributedStringFromMarkdown:markdown];
    self.labelStyled.attributedText = text;
    self.labelScrolling.attributedText = text;
    self.labelTappable.attributedText = text;
    [parser release];
}

#pragma mark - UITextViewDelegate

- (IBAction)textViewDidChange:(id)sender
{
    [self updateStyledText];
}

#pragma mark - ECTappableStyledLabelDelegate

- (void)styledLabel:(ECTTappableStyledLabel *)styledLabel didTapLink:(NSString *)link position:(CGPoint)position
{
    NSLog(@"link was %@, at %@", link, NSStringFromCGPoint(position));
}

@end
