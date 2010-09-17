// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 28/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECTouchAboutBoxController.h"


@implementation ECTouchAboutBoxController

ECPropertySynthesize(application);
ECPropertySynthesize(version);
ECPropertySynthesize(about);
ECPropertySynthesize(copyright);
ECPropertySynthesize(logo);

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
	
	
	NSBundle* bundle = [NSBundle mainBundle];
	NSDictionary* info = [bundle infoDictionary];
	
	NSError* error = nil;
	NSString* aboutPath = [bundle pathForResource:@"Credits" ofType:@"txt"];  
	NSString* aboutText = [NSString stringWithContentsOfFile: aboutPath encoding: NSUTF8StringEncoding error: &error];
	NSString* imageName = [info objectForKey: @"CFBundleIconFile"];
	NSString* applicationText = [info objectForKey: @"CFBundleDisplayName"];
	NSString* versionText = [NSString stringWithFormat: @"Version %@ (%@ %@)", [info objectForKey:@"CFBundleShortVersionString"], [info objectForKey:@"CFBundleVersion"], EC_CONFIGURATION_STRING];
	NSString* copyrightText = [info objectForKey: @"NSHumanReadableCopyright"];
	
	self.application.text = applicationText;
	self.version.text = versionText;
	self.about.text = aboutText;
	self.copyright.text = copyrightText;
	self.logo.image = [UIImage imageNamed: imageName];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
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
	ECPropertyDealloc(logo);

    [super dealloc];
}


@end
