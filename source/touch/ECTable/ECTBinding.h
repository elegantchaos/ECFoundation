// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 05/07/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTSection.h"

// --------------------------------------------------------------------------
//! Cell controller which sets a boolean property on an object.
// --------------------------------------------------------------------------

@interface ECTBinding : NSObject

@property (nonatomic, retain) NSString* detail;
@property (nonatomic, retain) NSString* label;
@property (nonatomic, retain) NSString* detailKey;
@property (nonatomic, retain) NSString* key;
@property (nonatomic, retain) NSString* disclosureTitle;
@property (nonatomic, retain) NSMutableDictionary* properties;

@property (nonatomic, retain) id object;
@property (nonatomic, assign) Class cellClass;
@property (nonatomic, assign) Class disclosureClass;
@property (nonatomic, assign) Class detailDisclosureClass;
@property (nonatomic, assign) BOOL canDelete;
@property (nonatomic, assign) BOOL canMove;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) SEL action;
@property (nonatomic, assign) id target;

+ (NSArray*)controllersWithObjects:(NSArray*)objects key:(NSString*)key properties:(NSDictionary*)properties;

+ (id)controllerWithObject:(id)object key:(NSString*)key properties:(NSDictionary*)properties;
+ (id)controllerWithObject:(id)object key:(NSString*)key label:(NSString*)label;

- (id)initWithObject:(id)object key:(NSString*)key;

- (id)objectValue;
- (void)setObjectValue:(id)value;

- (NSString*)identifierForSection:(ECTSection*)section;
- (id)valueForSection:(ECTSection*)section;
- (id)cellForSection:(ECTSection*)section;
- (CGFloat)heightForSection:(ECTSection*)section;
- (NSString*)disclosureTitleForSection:(ECTSection*)section;
- (Class)disclosureClassForSection:(ECTSection *)section detail:(BOOL)detail;
- (NSString*)labelForSection:(ECTSection*)section;
- (NSString*)detailForSection:(ECTSection*)section;
- (BOOL)canMoveInSection:(ECTSection*)section;
- (BOOL)canDeleteInSection:(ECTSection*)section;
- (void)didSetValue:(id)value forCell:(UITableViewCell<ECTSectionDrivenTableCell>*)cell;

- (NSString*)actionName;
- (void)setActionName:(NSString*)actionName;

- (void)addValueObserver:(id)observer options:(NSKeyValueObservingOptions)options;
- (void)removeValueObserver:(id)observer;

@end
