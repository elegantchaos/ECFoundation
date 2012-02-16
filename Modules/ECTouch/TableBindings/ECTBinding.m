// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 05/07/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTBinding.h"

#import "ECCoercion.h"
#import "ECLogging.h"

#import "ECTSimpleCell.h"
#import "ECTKeys.h"

#pragma mark - Constants

@interface ECTBinding()

- (id)lookupKey:(NSString*)keyIn;

@end

@implementation ECTBinding

#pragma mark - Channels

ECDefineDebugChannel(ECTValueCellControllerChannel);

#pragma mark - Properties

@synthesize actionSelector;
@synthesize canDelete;
@synthesize canMove;
@synthesize cellClass;
@synthesize enabled;
@synthesize mappings;
@synthesize object;
@synthesize properties;
@synthesize target;

#pragma mark - Object lifecycle

+ (id)controllerWithObject:(id)object properties:(NSDictionary*)properties
{
    ECTBinding* controller = [[self alloc] initWithObject:object];
    [controller setValuesForKeysWithDictionary:properties];

    return [controller autorelease];
}

+ (NSArray*)controllersWithObjects:(NSArray*)objects properties:(NSDictionary*)properties
{
    NSMutableArray* controllers = [NSMutableArray arrayWithCapacity:[objects count]];
    for (id object in objects)
    {
        ECTBinding* item = [[ECTBinding alloc] initWithObject:object];
        [item setValuesForKeysWithDictionary:properties];
        [controllers addObject:item];
        [item release];
    }
    
    return controllers;
}

- (id)initWithObject:(id)objectIn
{
    if ((self = [super init]) != nil) 
    {
        self.cellClass = [ECTSimpleCell class];
        self.object = objectIn;
        self.enabled = YES;
    }
    
    return self;
}

- (void)dealloc
{
    [mappings release];
    [object release];
    [properties release];
    
    [super dealloc];
}

#pragma mark - Utilities
- (id)valueForUndefinedKey:(NSString *)undefinedKey
{
    return [self.properties objectForKey:undefinedKey];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)undefinedKey
{
    if (!self.properties)
    {
        self.properties = [NSMutableDictionary dictionaryWithObject:value forKey:undefinedKey];
    }
    else
    {
        [self.properties setValue:value forKey:undefinedKey];
    }
}

- (id)lookupDisclosureKey:(NSString *)key
{
    NSDictionary* disclosure = [self lookupKey:ECTDisclosureKey];
    id result = [disclosure objectForKey:key];
    
    return result;
}

#pragma mark - ECSectionDrivenTableObject methods

- (NSString*)identifier
{
    return [ECCoercion asClassName:self.cellClass];
}

- (UIImage*)image
{
    id result = [self lookupKey:ECTImageKey];
    if ([result isMemberOfClass:[NSString class]])
    {
        result = [UIImage imageNamed:result];
    }
    
    return result;
}

- (id)lookupKey:(NSString*)keyIn
{
    // if we've got a fixed string, use it
    NSString* result = [self.properties objectForKey:keyIn];
    if (!result)
    {
        // if we've got a key set, use that to look up a value on the object
        NSString* mappedKey = [self.mappings objectForKey:keyIn];
        if (mappedKey)
        {
            result = [self.object valueForKeyPath:mappedKey];
        }
    }
    
    return result;

}

- (NSString*)label
{
    NSString* result = [self lookupKey:ECTLabelKey];
    if (!result)
    {
        result = [self.value description];
    }
    
    return result;
}


- (NSString*)detail
{
    // if we've got a fixed string, use it
    NSString* result = [self lookupKey:ECTDetailKey];

    // fall back to using the object value, as long as it's not already used for the label
    if (!result && self.label)
    {
        result = [self.value description];
    }
    
    return result;
}

- (Class)disclosureClassWithDetail:(BOOL)useDetail
{
    NSString* key = useDetail ? ECTDetailKey : ECTClassKey;
    id class = [self lookupDisclosureKey:key];
    Class result = [ECCoercion asClass:class];
    
    return result;
}

- (id)value
{
    id result = [self lookupKey:ECTValueKey];
    if (!result)
    {
        result = self.object;
    }
    
    return result;
}

- (void)setValue:(id)value
{
    NSString* key = [self.mappings objectForKey:ECTValueKey];
    [self.object setValue:value forKeyPath:key];
}

- (NSString*)action
{
    return NSStringFromSelector(self.actionSelector);
}

- (void)setAction:(NSString*)actionName
{
    self.actionSelector = NSSelectorFromString(actionName);
}

- (void)addValueObserver:(id)observer options:(NSKeyValueObservingOptions)options
{
    for (NSString* key in self.mappings)
    {
        NSString* mappedKey = [self.mappings objectForKey:key];
        [self.object addObserver:observer forKeyPath:mappedKey options:options context:self];
    }
}

- (void)removeValueObserver:(id)observer
{
    for (NSString* key in self.mappings)
    {
        NSString* mappedKey = [self.mappings objectForKey:key];
        [self.object removeObserver:observer forKeyPath:mappedKey];
    }
}

@end
