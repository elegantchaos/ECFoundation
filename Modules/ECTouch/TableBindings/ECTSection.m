// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECTSection.h"
#import "ECTSimpleCell.h"
#import "ECTSectionDrivenTableController.h"
#import "ECTBinding.h"
#import "ECLogging.h"
#import "ECAssertion.h"

@interface ECTSection()
@property (nonatomic, retain) NSArray* source;
@property (nonatomic, retain) ECTBinding* addCell;
@property (nonatomic, retain) NSDictionary* sectionProperties;
@property (nonatomic, retain) NSDictionary* allRowProperties;
@property (nonatomic, retain) NSArray* eachRowProperties;

@end

@implementation ECTSection

#pragma mark - Debug Channels

ECDefineDebugChannel(ECTSectionControllerChannel);

#pragma mark - Properties

@synthesize addCell;
@synthesize addDisclosureTitle;
@synthesize content;
@synthesize canDelete;
@synthesize canMove;
@synthesize canSelect;
@synthesize cellIdentifier;
@synthesize footer;
@synthesize header;
@synthesize cellClass;
@synthesize detailDisclosureClass;
@synthesize disclosureClass;
@synthesize source;
@synthesize table;
@synthesize variableRowHeight;

@synthesize sectionProperties;
@synthesize allRowProperties;
@synthesize eachRowProperties;

#pragma mark - Constants

NSString *const ECTActionKey = @"actionName";
NSString *const ECTCanDeleteKey = @"canDelete";
NSString *const ECTCanMoveKey = @"canMove";
NSString *const ECTCellClassKey = @"cellClass";
NSString *const ECTDetailKey = @"detail";
NSString *const ECTDetailKeyKey = @"detailKey";
NSString *const ECTDisclosureBackKey = @"disclosureBackTitle";
NSString *const ECTDisclosureClassKey = @"disclosureClass";
NSString *const ECTDisclosureTitleKey = @"disclosureTitle";
NSString *const ECTEnabledKey = @"enabled";
NSString *const ECTImageKey = @"image";
NSString *const ECTImageKeyKey = @"imageKey";
NSString *const ECTLabelKey = @"label";
NSString *const ECTPlaceholderKey = @"placeholder";
NSString *const ECTTargetKey = @"target";
NSString *const ECTValueKey = @"value";

#pragma mark - Factory Methods

+ (ECTSection*)sectionWithProperties:(id)propertiesOrPlistName
{
    NSDictionary* properties;
    if ([propertiesOrPlistName isKindOfClass:[NSDictionary class]])
    {
        properties = propertiesOrPlistName;
    }
    else
    {
        NSURL* url = [[NSBundle mainBundle] URLForResource:propertiesOrPlistName withExtension:@"plist"];
        properties = [NSDictionary dictionaryWithContentsOfURL:url];
    }

    ECTSection* section = [[ECTSection alloc] init];

    NSDictionary* sectionProperties = [properties objectForKey:@"section"];

    section.sectionProperties = sectionProperties;
    section.allRowProperties = [properties objectForKey:@"rows"];
    section.eachRowProperties = [properties objectForKey:@"eachRow"];
    [section setValuesForKeysWithDictionary:sectionProperties];
    
    return [section autorelease];
}

+ (ECTSection*)sectionWithProperties:(id)propertiesOrPlistName boundToArray:(NSArray*)array
{
    ECTSection* section = [self sectionWithProperties:propertiesOrPlistName];
    [section bindArray:array];
    
    return section;
}

+ (ECTSection*)sectionWithProperties:(id)propertiesOrPlistName boundToObject:(id)object
{
    ECTSection* section = [self sectionWithProperties:propertiesOrPlistName];
    [section bindObject:object];

    return section;
}

#pragma mark - Object lifecycle

- (id)init
{
    self = [super init];
    if (self) 
    {
        self.cellIdentifier = @"DefaultCellIdentifier";
        self.cellClass = [ECTSimpleCell class];
    }
    
    return self;
}

- (void)dealloc
{
    [addCell release];
    [cellIdentifier release];
    [content release];
    [header release];
    [footer release];
    [source release];
    
    [super dealloc];
}

#pragma mark - Utilities

- (BOOL)isMutable
{
    return [self.content isKindOfClass:[NSMutableArray class]] && [self.source isKindOfClass:[NSMutableArray class]];
}

#pragma mark - ECTSectionController methods

- (void)bindArray:(NSArray*)array
{
    self.source = array;
    self.content = [NSMutableArray arrayWithArray:[ECTBinding controllersWithObjects:array properties:self.allRowProperties]];
}

- (void)bindSource:(NSArray*)sourceIn key:(NSString*)key properties:(NSDictionary*)properties
{
    self.source = sourceIn;
    NSMutableDictionary* expandedProps = [NSMutableDictionary dictionaryWithDictionary:properties];
    [expandedProps setObject:key forKey:ECTValueKey];
    self.allRowProperties = expandedProps;
    self.content = [NSMutableArray arrayWithArray:[ECTBinding controllersWithObjects:sourceIn key:key properties:expandedProps]];
}

- (void)sourceChanged
{
    self.content = [NSMutableArray arrayWithArray:[ECTBinding controllersWithObjects:self.source properties:self.allRowProperties]];
    [self reloadData];
}

- (void)addSource:(id)object
{
    if (!self.source)
    {
        self.source = [NSMutableArray array];
    }
    
    if (!self.content)
    {
        self.content = [NSMutableArray array];
    }

    [(NSMutableArray*) self.source addObject:object];

    ECAssert([self.source isKindOfClass:[NSMutableArray class]]);
    ECAssert([self.content isKindOfClass:[NSMutableArray class]]);
}

- (void)bindObject:(id)object
{
    NSUInteger count = [self.eachRowProperties count];
    for (NSUInteger index = 0; index < count; ++index)
    {
        [self addSource:object];
        
        NSMutableDictionary* combined = [NSMutableDictionary dictionaryWithDictionary:self.allRowProperties];
        [combined addEntriesFromDictionary:[self.eachRowProperties objectAtIndex:index]];
        
        [(NSMutableArray*) self.content addObject:[ECTBinding controllerWithObject:object properties:combined]];
    }
    
}

- (void)addRow:(id)object
{
    [self addSource:object];
    
    NSMutableDictionary* combined = [NSMutableDictionary dictionaryWithDictionary:self.allRowProperties];
    NSUInteger index = [self.content count];
    if (index < [self.eachRowProperties count])
    {
        [combined addEntriesFromDictionary:[self.eachRowProperties objectAtIndex:index]];
    }
    
    [(NSMutableArray*) self.content addObject:[ECTBinding controllerWithObject:object properties:combined]];
}

- (void)addRow:(id)object key:(NSString*)key properties:(NSDictionary*)properties
{
    [self addSource:object];
    
    NSMutableDictionary* combined = [NSMutableDictionary dictionaryWithDictionary:self.allRowProperties];
    [combined addEntriesFromDictionary:properties];
    NSUInteger index = [self.content count];
    if (index < [self.eachRowProperties count])
    {
        [combined addEntriesFromDictionary:[self.eachRowProperties objectAtIndex:index]];
    }
    
    [(NSMutableArray*) self.content addObject:[ECTBinding controllerWithObject:object key:key properties:combined]];
}

- (void)makeAddableWithObject:(id)object key:(NSString*)key properties:(NSDictionary*)properties
{
    if (object)
    {
        self.addCell = [ECTBinding controllerWithObject:object key:key properties:properties];
    }
    else
    {
        self.addCell = nil;
    }
}

- (UITableView*)tableView
{
    return (UITableView*)self.table.view;
}

- (BOOL)canEdit
{
    return self.canMove || self.canDelete; // - should add cell cause Edit button to show? || (self.addCell != nil);
}

- (void)reloadData
{
    [[self tableView] reloadData];
}

#pragma mark - TableView methods

- (ECTBinding*)bindingForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id result;
    
    if (self.addCell && ((NSUInteger) indexPath.row == [self.content count]))
    {
        result = self.addCell;
    }
    else
    {
        result = [self.content objectAtIndex:indexPath.row];
    }
    
    return result;
}

- (NSInteger)numberOfRowsInSection
{
    NSInteger result = [self.content count];
    if (self.addCell)
    {
        ++result;
    }
    
    return result;
}

- (NSString *)titleForHeaderInSection
{
    return self.header;
}

- (NSString *)titleForFooterInSection
{
    return self.footer;
}


- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ECTBinding* binding = [self bindingForRowAtIndexPath:indexPath];

    NSString* identifier = [binding identifierForSection:self];
    
    UITableViewCell<ECTSectionDrivenTableCell>* cell = (UITableViewCell<ECTSectionDrivenTableCell>*) [[self tableView] dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) 
    {
        cell = [binding cellForSection:self identifier:identifier];
    }
    
    [cell setupForBinding:binding section:self];
    
    return cell;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat result = self.tableView.rowHeight;
    
    if (self.variableRowHeight)
    {
        ECTBinding* binding = [self bindingForRowAtIndexPath:indexPath];
        result = [binding heightForSection:self];
    }
    
    return result;
}

- (Class)disclosureClassForBinding:(ECTBinding*)binding detail:(BOOL)detail
{
    id class = [binding disclosureClassForSection:self detail:detail];
    Class result = [ECTBinding normalisedClass:class];
    
    return result;
}

- (UIViewController*)disclosureViewForRowAtIndexPath:(NSIndexPath*)indexPath detail:(BOOL)detail
{
    ECTBinding* binding = [self bindingForRowAtIndexPath:indexPath];
    Class class = [self disclosureClassForBinding:binding detail:detail];
    
    NSString* nib = NSStringFromClass(class);
    UIViewController* view;
    if ([[NSBundle mainBundle] pathForResource:nib ofType:@"nib"])
    {
        view = [[class alloc] initWithNibName:nib bundle:nil];
    }
    else
    {
        view = [[class alloc] initWithNibName:nil bundle:nil];
    }
    
    ECDebug(ECTSectionControllerChannel, @"made disclosure view of class %@ for path %@", nib, indexPath);
    
    return [view autorelease];
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[self tableView] cellForRowAtIndexPath:indexPath];
    if ([cell conformsToProtocol:@protocol(ECTSectionDrivenTableCell)])
    {
        ECTBinding* binding = [self bindingForRowAtIndexPath:indexPath];
        SelectionMode selectionMode = [(id<ECTSectionDrivenTableCell>)cell didSelectWithBinding:binding section:self];
        BOOL keepSelected = (selectionMode == SelectAlways) || ((selectionMode == SelectIfSelectable) && self.canSelect);
        if (keepSelected)
        {
            // TODO update selection binding here so that something knows what the selection is?
        }
        else
        {
            [[self tableView] deselectRowAtIndexPath:indexPath animated:YES];
        }
    }
}

- (BOOL)canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL result = self.canMove || self.canDelete;
    if (result)
    {
        id cell = [[self tableView] cellForRowAtIndexPath:indexPath];
        if ([cell conformsToProtocol:@protocol(ECTSectionDrivenTableCell)])
        {
            result = [cell canMoveInSection:self] || [cell canDeleteInSection:self];
        }
    }
    
    return result;
}

- (BOOL)canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL result = self.canMove;
    if (result)
    {
        id cell = [[self tableView] cellForRowAtIndexPath:indexPath];
        if ([cell conformsToProtocol:@protocol(ECTSectionDrivenTableCell)])
        {
            result = [cell canMoveInSection:self];
        }
    }

    return result;
}

- (void)moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    // if we've got here, then our content array is definitely mutable... honest
    ECAssert([self isMutable]);
    
    [(NSMutableArray*)self.content exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
    [(NSMutableArray*)self.source exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
}

- (void)moveRowFromSection:(ECTSection*)section atIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    
}

- (void)commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // if we've got here, then our content array is definitely mutable... honest
        ECAssert([self isMutable]);
        
        [(NSMutableArray*)self.content removeObjectAtIndex:indexPath.row];
        [(NSMutableArray*)self.source removeObjectAtIndex:indexPath.row];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}

@end
