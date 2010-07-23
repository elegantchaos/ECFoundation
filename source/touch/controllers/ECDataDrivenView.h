//
//  ECDataDrivenView.h
//  ECFoundation
//
//  Created by Sam Deane on 22/07/2010.
//  Copyright 2010 Elegant Chaos. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ECDataDrivenView

- (id) initWithNibName: (NSString*) nibNameOrNil bundle:(NSBundle *)nibBundleOrNil data: (NSDictionary*) data defaults: (NSDictionary*) defaults;
- (void) setData: (NSDictionary*) data defaults: (NSDictionary*) defaults;

@end