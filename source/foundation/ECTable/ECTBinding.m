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

#pragma mark - Constants


@implementation ECTBinding

#pragma mark - Channels

ECDefineDebugChannel(ECTValueCellControllerChannel);

#pragma mark - Properties

@synthesize action;
@synthesize canDelete;
@synthesize canMove;
@synthesize cellClass;
@synthesize detailDisclosureClass;
@synthesize disclosureClass;
@synthesize disclosureTitle;
@synthesize enabled;
@synthesize label;
@synthesize object;
@synthesize key;
@synthesize target;

#pragma mark - Object lifecycle

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
    [disclosureTitle release];
    [label release];
    [object release];
    [key release];
    
    [super dealloc];
}

#pragma mark - ECSectionDrivenTableObject methods

- (NSString*)identifierForSection:(ECTSection*)section
{
    return NSStringFromClass([self cellClass]);
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

- (NSString*)disclosureTitleForSection:(ECTSection*)section
{
    NSString* result = self.disclosureTitle;
    if (!result)
    {
        result = [self labelForSection:section];
    }
    
    return result;
}

- (UITableViewCell<ECTSectionDrivenTableCell> *)cellForSection:(ECTSection*)section
{
    NSString* identifier = [self identifierForSection:section];
    return [[[self.cellClass alloc] initWithBinding:self section:section reuseIdentifier:identifier] autorelease];
}

- (CGFloat)heightForSection:(ECTSection*)section
{
    return [self.cellClass heightForBinding:self section:section];
}

- (Class)disclosureClassForSection:(ECTSection *)section detail:(BOOL)detail
{
    return detail ? self.detailDisclosureClass : self.disclosureClass;
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

@end
