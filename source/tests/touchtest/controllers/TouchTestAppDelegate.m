// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 01/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "TouchTestAppDelegate.h"

#import <ECFoundation/ECDataItem.h>
#import <ECFoundation/NSString+ECUtilities.h>
#import <ECFoundation/ECLogManager.h>

// --------------------------------------------------------------------------
// Constants
// --------------------------------------------------------------------------

static NSString *const kNameSetting = @"Name";
static NSString *const kPasswordSetting = @"Password";


@implementation TouchTestAppDelegate

// --------------------------------------------------------------------------
// Properties
// --------------------------------------------------------------------------

@synthesize window;
@synthesize tabBarController;

ECPropertySynthesize(name);
ECPropertySynthesize(password);

// --------------------------------------------------------------------------
//! Setup after launching.
// --------------------------------------------------------------------------

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{
	[[ECLogManager sharedInstance] registerDefaultHandler];

	NSString* pointlessString = @"blah";
	[pointlessString splitWordsIntoInts];
	
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	[defaults registerDefaults: [NSDictionary dictionaryWithObjectsAndKeys: @"Sam Deane", kNameSetting, @"top secret", kPasswordSetting, nil]];
	
	self.name = [ECDataItem itemWithObjectsAndKeys: @"Name", kLabelKey, [defaults stringForKey: kNameSetting], kValueKey, nil];
	self.password = [ECDataItem itemWithObjectsAndKeys: @"Password", kLabelKey, [defaults stringForKey: kPasswordSetting], kValueKey, [NSNumber numberWithBool:YES], kSecureKey, nil];
	
	// Override point for customization after application launch.
	// Add the tab bar controller's current view as a subview of the window
	[window addSubview:tabBarController.view];
	[window makeKeyAndVisible];
    return YES;
}

// --------------------------------------------------------------------------
//! Clean up before quitting.
// --------------------------------------------------------------------------

- (void)applicationWillTerminate:(UIApplication *)application 
{
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setValue: [self.name objectForKey: kValueKey] forKey: kNameSetting];
	[defaults setValue: [self.password objectForKey: kValueKey] forKey: kPasswordSetting];
	[defaults synchronize];
	
	[[ECLogManager sharedInstance] shutdown];
}

// --------------------------------------------------------------------------
//! Release retained data.
// --------------------------------------------------------------------------

- (void)dealloc 
{

	ECPropertyDealloc(name);
	ECPropertyDealloc(password);

	[window release];
	[tabBarController release];
    [super dealloc];
}

@end

