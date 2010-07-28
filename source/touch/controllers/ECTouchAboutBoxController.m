//
//  ECAboutBoxController.m
//  ECFoundation
//
//  Created by Sam Deane on 28/07/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//

#import "ECTouchAboutBoxController.h"


@implementation ECTouchAboutBoxController

ECPropertySynthesize(application);
ECPropertySynthesize(version);
ECPropertySynthesize(about);
ECPropertySynthesize(copyright);

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
	if (!nibNameOrNil)
	{
		nibNameOrNil = @"ECTouchAboutBox";
	}
	
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) 
	{
        // Custom initialization
    }
	
    return self;
}

- (void) viewDidLoad 
{
	[super viewDidLoad];
	
	NSString* applicationText = @"Blah App";
	NSString* versionText = @"Version 1.0 (16 " EC_CONFIGURATION_STRING ")";
	NSString* aboutText = @"About the app. Blah blah.";
	NSString* copyrightText = @"(C) 2010 Sam Deane, Elegant Chaos.";
	
	self.application.text = applicationText;
	self.version.text = versionText;
	self.about.text = aboutText;
	self.copyright.text = copyrightText;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
	ECPropertyDealloc(application);
	ECPropertyDealloc(version);
	ECPropertyDealloc(about);
	ECPropertyDealloc(copyright);

    [super dealloc];
}


@end
