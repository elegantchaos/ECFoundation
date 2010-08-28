//
//  ECDebugViewController.m
//  ECFoundation
//
//  Created by Sam Deane on 28/08/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//

#import "ECDebugViewController.h"


@implementation ECDebugViewController

- (void) viewDidLoad
{
	ECDataItem* data = [ECDataItem item];
	
	ECDataItem* section2 = [ECDataItem itemWithItemsWithKey: kLabelKey andValues: @"four", @"five", @"six", nil];
	[section2 setObject: @"Selectable Section" forKey: kHeaderKey];
	[section2 setBooleanDefault: YES forKey: kSelectableKey];
	[data addItem: section2];
	
	self.data = data;
	self.title = @"Debug";
}

@end
