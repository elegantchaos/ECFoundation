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

@synthesize action;
@synthesize canDelete;
@synthesize canMove;
@synthesize cellClass;
@synthesize detail;
@synthesize detailDisclosureClass;
@synthesize detailKey;
@synthesize disclosureClass;
@synthesize disclosureTitle;
@synthesize enabled;
@synthesize label;
@synthesize key;
@synthesize object;
@synthesize properties;
@synthesize target;

#pragma mark - Object lifecycle

+ (id)controllerWithObject:(id)object properties:(NSDictionary*)properties
{
    NSString* key = [properties objectForKey:ECTValueKey];
    return [self controllerWithObject:object key:key properties:properties];
}

+ (id)controllerWithObject:(id)object key:(NSString*)key properties:(NSDictionary*)properties
{
    ECTBinding* controller = [[self alloc] initWithObject:object key:key];
    [controller setValuesForKeysWithDictionary:properties];
    
    return [controller autorelease];
}

+ (id)controllerWithObject:(id)object key:(NSString*)key label:(NSString*)label
{
    ECTBinding* controller = [[self alloc] initWithObject:object key:key];
    controller.label = label;
    
    return [controller autorelease];
}

+ (NSArray*)controllersWithObjects:(NSArray*)objects properties:(NSDictionary*)properties
{
    NSString* key = [properties objectForKey:ECTValueKey];
    return [self controllersWithObjects:objects key:key properties:properties];
}

+ (NSArray*)controllersWithObjects:(NSArray*)objects key:(NSString*)key properties:(NSDictionary*)properties
{
    NSMutableArray* controllers = [NSMutableArray arrayWithCapacity:[objects count]];
    for (id object in objects)
    {
        ECTBinding* item = [[ECTBinding alloc] initWithObject:object key:key];
        [item setValuesForKeysWithDictionary:properties];
        [controllers addObject:item];
        [item release];
    }
    
    return controllers;
}

- (id)initWithObject:(id)objectIn key:(NSString*)keyIn
{
    if ((self = [super init]) != nil) 
    {
        self.cellClass = [ECTSimpleCell class];
        self.object = objectIn;
        self.key = keyIn;
        self.enabled = YES;
    }
    
    return self;
}

- (void)dealloc
{
    [detail release];
    [detailKey release];
    [disclosureTitle release];
    [label release];
    [key release];
    [object release];
    [properties release];
    
    [super dealloc];
}

#pragma mark - Class Utilities

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

- (NSString*)identifierForSection:(ECTSection*)section
{
    return [ECTBinding normalisedClassName:self.cellClass];
}

- (id)valueForSection:(ECTSection*)section
{
    id result;
    
    if (self.key)
    {
        result = [self.object valueForKeyPath:self.key];
    }
    else
    {
        result = self.object;
    }
    
    return result;
}

- (NSString*)labelForSection:(ECTSection*)section
{
    NSString* result = self.label;
    if (!result)
    {
        result = [[self valueForSection:section] description];
    }
    
    return result;
}

- (UIImage*)imageForSection:(ECTSection*)section
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

- (NSString*)detailForSection:(ECTSection*)section
{
    // if we've got a fixed string, use it
    NSString* result = self.detail;
    if (!result)
    {
        // if we've got a key set, use that to look up a value on the object
        if (self.detailKey)
        {
            result = [self.object valueForKeyPath:self.detailKey];
        }
    }
    
    // fall back to using the object value, as long as it's not already used for the label
    if (!result && self.label)
    {
        result = [[self valueForSection:section] description];
    }
    
    return result;
}

- (NSString*)disclosureTitleForSection:(ECTSection*)section
{
    NSString* result = self.disclosureTitle;
    if (!result)
    {
        result = [self labelForSection:section];
    }
    
    return result;
}

- (UITableViewCell<ECTSectionDrivenTableCell> *)cellForSection:(ECTSection*)section identifier:(NSString*)identifier
{
    Class class = [ECTBinding normalisedClass:self.cellClass];
    return [[[class alloc] initWithBinding:self section:section reuseIdentifier:identifier] autorelease];
}

- (CGFloat)heightForSection:(ECTSection*)section
{
    return [self.cellClass heightForBinding:self section:section];
}

- (Class)disclosureClassForSection:(ECTSection *)section detail:(BOOL)useDetail
{
    id class = useDetail ? self.detailDisclosureClass : self.disclosureClass;
    Class result = [ECTBinding normalisedClass:class];
    
    return result;
}

- (id)objectValue
{
    id result;
    if (self.key)
    {
        result = [self.object valueForKeyPath:self.key];
    }
    else
    {
        result = self.object;
    }
    
    return result;
}

- (void)setObjectValue:(id)value
{
    [self.object setValue:value forKeyPath:self.key];
}

- (void)didSetValue:(id)value forCell:(UITableViewCell<ECTSectionDrivenTableCell>*)cell
{
    ECDebug(ECTValueCellControllerChannel, @"value changed from %@ to %@", [self objectValue], value);
    
    [self setObjectValue:value];
}

- (BOOL)canDeleteInSection:(ECTSection*)section
{
    return self.canDelete;
}

- (BOOL)canMoveInSection:(ECTSection*)section
{
    return self.canMove;
}

- (NSString*)actionName
{
    return NSStringFromSelector(self.action);
}

- (void)setActionName:(NSString*)actionName
{
    self.action = NSSelectorFromString(actionName);
}

- (void)addValueObserver:(id)observer options:(NSKeyValueObservingOptions)options
{
    NSString* keyToObserve = self.key;
    if (keyToObserve)
    {
        [self.object addObserver:observer forKeyPath:keyToObserve options:options context:self];
    }
}

- (void)removeValueObserver:(id)observer
{
    NSString* keyToObserve = self.key;
    if (keyToObserve)
    {
        [self.object removeObserver:observer forKeyPath:keyToObserve];
    }
}

@end
