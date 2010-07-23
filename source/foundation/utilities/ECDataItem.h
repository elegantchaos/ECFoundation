//
//  ECDataItem.h
//  ECFoundation
//
//  Created by Sam Deane on 23/07/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECDataItem : NSObject 
{
	ECPropertyDefineVariable(data, NSDictionary*);
	ECPropertyDefineVariable(defaults, NSDictionary*);
	ECPropertyDefineVariable(items, NSArray*);
}

ECPropertyDefineRN(data, NSDictionary*);
ECPropertyDefineRN(defaults, NSDictionary*);
ECPropertyDefineRN(items, NSArray*);

- (id) init;
- (id) initWithObjectsAndKeys: (id)firstObject, ... NS_REQUIRES_NIL_TERMINATION;
- (id) initWithItems: (NSArray*) items;
- (id) initWithItems: (NSArray*) items defaults: (NSDictionary*) defaults;
- (id) initWithData: (NSDictionary*) data items: (NSArray*) items defaults: (NSDictionary*) defaults;

@end

// --------------------------------------------------------------------------
// Data Key Constants
// --------------------------------------------------------------------------

extern NSString *const kHeaderKey;
extern NSString *const kFooterKey;
extern NSString *const kItemsKey;
extern NSString *const kLabelKey;
extern NSString *const kDetailKey;
extern NSString *const kAccessoryKey;
extern NSString *const kDefaultsKey;
extern NSString *const kMoveableKey;
extern NSString *const kSubviewKey;
extern NSString *const kValuesKey;
extern NSString *const kEditableKey;
extern NSString *const kSelectionKey;
