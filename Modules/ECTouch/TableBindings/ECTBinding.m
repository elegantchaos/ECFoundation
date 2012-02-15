// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 05/07/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTBinding.h"
#import "ECTSimpleCell.h"
#import "ECLogging.h"

#pragma mark - Constants

@implementation ECTBinding

#pragma mark - Channels

ECDefineDebugChannel(ECTValueCellControllerChannel);

#pragma mark - Properties

@synthesize actionSelector;
@synthesize canDelete;
@synthesize canMove;
@synthesize cellClass;
@synthesize detailDisclosureClass;
@synthesize disclosureClass;
@synthesize enabled;
@synthesize object;
@synthesize properties;
@synthesize keys;
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
    [keys release];
    [object release];
    [properties release];
    
    [super dealloc];
}

#pragma mark - Utilities

+ (Class)normalisedClass:(id)classOrClassName
{
    if ([classOrClassName isKindOfClass:[NSString class]])
     {
         classOrClassName = NSClassFromString(classOrClassName);
     }
    
    return classOrClassName;
}


+ (NSString*)normalisedClassName:(id)classOrClassName
{
    if (![classOrClassName isKindOfClass:[NSString class]])
    {
        classOrClassName = NSStringFromClass(classOrClassName);
    }
    
    return classOrClassName;
}

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

#pragma mark - ECSectionDrivenTableObject methods

- (NSString*)identifier
{
    return [ECTBinding normalisedClassName:self.cellClass];
}

- (UIImage*)image
{
    UIImage* result = nil;
    id value = [self.properties valueForKey:ECTImageKeyKey];
    if (value)
    {
        value = [self.object valueForKeyPath:value];
    }
    else
    {
        value = [self.properties valueForKey:ECTImageKey];
    }
    
    if ([value isMemberOfClass:[NSString class]])
    {
        result = [UIImage imageNamed:value];
    }
    else
    {
        result = value;
    }
    
    return result;
}

- (NSString*)lookupKey:(NSString*)keyIn
{
    // if we've got a fixed string, use it
    NSString* result = [self.properties objectForKey:keyIn];
    if (!result)
    {
        // if we've got a key set, use that to look up a value on the object
        NSString* mappedKey = [self.keys objectForKey:keyIn];
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
        result = [[self objectValue] description];
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
        result = [[self objectValue] description];
    }
    
    return result;
}

- (NSString*)disclosureTitle
{
    NSString* result = [self.properties objectForKey:ECTDisclosureTitleKey];
    if (!result)
    {
        result = [self label];
    }
    
    return result;
}

- (Class)disclosureClassWithDetail:(BOOL)useDetail
{
    id class = useDetail ? self.detailDisclosureClass : self.disclosureClass;
    Class result = [ECTBinding normalisedClass:class];
    
    return result;
}

- (id)objectValue
{
    id result = [self lookupKey:ECTValueKey];
    if (!result)
    {
        result = self.object;
    }
    
    return result;
}

- (void)setObjectValue:(id)value
{
    NSString* key = [self.keys objectForKey:ECTValueKey];
    [self.object setValue:value forKeyPath:key];
}

- (void)didSetValue:(id)value forCell:(UITableViewCell<ECTSectionDrivenTableCell>*)cell
{
    ECDebug(ECTValueCellControllerChannel, @"value changed from %@ to %@", [self objectValue], value);
    
    [self setObjectValue:value];
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
    for (NSString* key in self.keys)
    {
        NSString* mappedKey = [self.keys objectForKey:key];
        [self.object addObserver:observer forKeyPath:mappedKey options:options context:self];
    }
}

- (void)removeValueObserver:(id)observer
{
    for (NSString* key in self.keys)
    {
        NSString* mappedKey = [self.keys objectForKey:key];
        [self.object removeObserver:observer forKeyPath:mappedKey];
    }
}

@end
