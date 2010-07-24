//
//  ECDataDrivenView.h
//  ECFoundation
//
//  Created by Sam Deane on 22/07/2010.
//  Copyright 2010 Elegant Chaos. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ECDataItem;

@protocol ECDataDrivenView

- (id) initWithNibName: (NSString*) nibNameOrNil bundle:(NSBundle *)nibBundleOrNil data: (ECDataItem*) data;

@end