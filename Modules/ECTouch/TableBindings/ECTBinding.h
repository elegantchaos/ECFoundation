// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 05/07/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTSection.h"
#import "ECMacros.h"

// --------------------------------------------------------------------------
//! Cell controller which sets a boolean property on an object.
// --------------------------------------------------------------------------

@interface ECTBinding : NSObject

@property (nonatomic, retain) id object;
@property (nonatomic, retain) NSMutableDictionary* properties;
@property (nonatomic, retain) NSMutableDictionary* mappings;

@property (nonatomic, assign) id cellClass;
@property (nonatomic, assign) BOOL canDelete;
@property (nonatomic, assign) BOOL canMove;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) SEL actionSelector;
@property (nonatomic, assign) NSString* action; // this is deliberately assign, since the actual selector is stored
@property (nonatomic, assign) id target;

+ (NSArray*)controllersWithObjects:(NSArray*)objects properties:(NSDictionary*)properties;
+ (id)controllerWithObject:(id)object properties:(NSDictionary*)properties;

+ (Class)normalisedClass:(id)classOrClassName;
+ (NSString*)normalisedClassName:(id)classOrClassName;

- (id)initWithObject:(id)object;

- (id)objectValue;
- (void)setObjectValue:(id)value;
- (id)lookupKey:(NSString*)keyIn;

- (id)lookupDisclosureKey:(NSString*)key;

- (Class)disclosureClassWithDetail:(BOOL)detail;
- (NSString*)label;
- (NSString*)detail;
- (UIImage*)image;

- (void)addValueObserver:(id)observer options:(NSKeyValueObservingOptions)options;
- (void)removeValueObserver:(id)observer;

@end
