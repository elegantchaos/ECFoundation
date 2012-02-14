// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@class ECTBinding;
@class ECTSectionDrivenTableController;

typedef enum
{
    SelectNever,
    SelectAlways,
    SelectIfSelectable
} SelectionMode;

extern NSString *const ECTActionKey;
extern NSString *const ECTCanMoveKey;
extern NSString *const ECTCanDeleteKey;
extern NSString *const ECTCellClassKey;
extern NSString *const ECTDetailKey;
extern NSString *const ECTDetailKeyKey;
extern NSString *const ECTDisclosureBackKey;
extern NSString *const ECTDisclosureClassKey;
extern NSString *const ECTDisclosureTitleKey;
extern NSString *const ECTEnabledKey;
extern NSString *const ECTImageKey;
extern NSString *const ECTImageKeyKey;
extern NSString *const ECTLabelKey;
extern NSString *const ECTPlaceholderKey;
extern NSString *const ECTTargetKey;
extern NSString* const ECTValueKey;

// --------------------------------------------------------------------------
//! Controller for a section in a table.
// --------------------------------------------------------------------------

@interface ECTSection : NSObject

@property (nonatomic, retain) NSString* addDisclosureTitle;
@property (nonatomic, retain) NSString* cellIdentifier;
@property (nonatomic, retain) NSString* header;
@property (nonatomic, retain) NSString* footer;
@property (nonatomic, assign) Class detailDisclosureClass;
@property (nonatomic, assign) Class disclosureClass;
@property (nonatomic, assign) Class cellClass;
@property (nonatomic, assign) BOOL canDelete;
@property (nonatomic, assign) BOOL canMove;
@property (nonatomic, assign) BOOL canSelect;
@property (nonatomic, assign) BOOL variableRowHeight;
@property (nonatomic, assign) ECTSectionDrivenTableController* table;
@property (nonatomic, retain) NSArray* content;

+ (ECTSection*)sectionFromDictionary:(NSDictionary*)properties;
+ (ECTSection*)sectionFromPlist:(NSString*)plist;
+ (ECTSection*)sectionFromDictionary:(NSDictionary*)properties boundToArray:(NSArray*)array;
+ (ECTSection*)sectionFromPlist:(NSString*)plist boundToArray:(NSArray*)array;

- (void)addRow:(id)object key:(NSString*)key properties:(NSDictionary*)properties;
- (void)makeAddableWithObject:(id)object key:(NSString*)key properties:(NSDictionary*)properties;
- (void)bindArray:(NSArray*)array;
- (void)bindSource:(NSArray*)source key:(NSString*)key properties:(NSDictionary*)properties;
- (void)sourceChanged;

- (BOOL)canEdit;
- (void)reloadData;
- (UITableView*)tableView;

- (NSInteger)numberOfRowsInSection;
- (NSString *)titleForHeaderInSection;
- (NSString *)titleForFooterInSection;
- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (Class)disclosureClassForBinding:(ECTBinding*)binding detail:(BOOL)detail;
- (UIViewController*)disclosureViewForRowAtIndexPath:(NSIndexPath*)indexPath detail:(BOOL)detail;
- (id)bindingForRowAtIndexPath:(NSIndexPath*)indexPath;
- (BOOL)canEditRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;
- (void)moveRowFromSection:(ECTSection*)section atIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath ;
- (void)commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol ECTSectionDrivenTableCell <NSObject>
+ (CGFloat)heightForBinding:(ECTBinding*)binding section:(ECTSection*)section;

- (id)initWithBinding:(ECTBinding*)binding section:(ECTSection*)section reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setupForBinding:(ECTBinding*)binding section:(ECTSection*)section;
- (SelectionMode)didSelectWithBinding:(ECTBinding*)binding section:(ECTSection*)section;
- (BOOL)canDeleteInSection:(ECTSection*)section;
- (BOOL)canMoveInSection:(ECTSection*)section;
@end


