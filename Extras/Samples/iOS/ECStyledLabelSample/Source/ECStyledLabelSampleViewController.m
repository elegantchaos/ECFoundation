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

@interface ECStyledLabelSampleViewController()

@property (nonatomic, retain) ECDebugViewController* debugController;

- (void)updateStyledText;

@end

@implementation ECStyledLabelSampleViewController

#pragma mark - Properties

@synthesize debugController;
@synthesize labelStyled;
@synthesize labelScrolling;
@synthesize textViewMarkdown;

- (void)dealloc 
{
    [debugController release];
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
    
    self.debugController = [[[ECDebugViewController alloc] initWithNibName:nil bundle:nil] autorelease];
}

- (void)viewDidUnload
{
    self.debugController = nil;
    
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateStyledText];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)tappedShowDebugView:(id)sender
{
    [self.navigationController pushViewController:self.debugController animated:YES];
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

@end
