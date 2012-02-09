//
//  ECStyledLabelSampleViewController.m
//  ECStyledLabelSample
//
//  Created by Sam Deane on 28/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ECStyledLabelSampleViewController.h"

#import "ECDebugViewController.h"
#import "ECMarkdownParser.h"
#import "ECDebugViewPopoverController.h"
#import "ECPopoverBarButtonItem.h"
#import "ECStyledLabel.h"

@interface ECStyledLabelSampleViewController()

- (void)updateStyledText;

@end

@implementation ECStyledLabelSampleViewController

#pragma mark - Properties

@synthesize labelStyled;
@synthesize labelScrolling;
@synthesize textViewMarkdown;

- (void)dealloc 
{
    [labelScrolling release];
    [labelStyled release];
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
    
    UIBarButtonItem* debugButton = [[ECPopoverBarButtonItem alloc] initWithTitle:@"Debug" style:UIBarButtonItemStylePlain content:@"ECDebugViewPopoverController"];
    self.navigationItem.rightBarButtonItem = debugButton;
    [debugButton release];
    
    self.title = @"ECStyledLabel Test Bed";
}

- (void)viewDidUnload
{
    self.labelStyled = nil;
    self.labelScrolling = nil;
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
    [parser release];
}

#pragma mark - UITextViewDelegate

- (IBAction)textViewDidChange:(id)sender
{
    [self updateStyledText];
}

@end
