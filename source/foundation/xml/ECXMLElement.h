// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@interface ECXMLElement : NSObject 
{
	NSString*				mName;
	NSDictionary*			mAttributes;
	NSMutableDictionary*	mProperties;
	NSMutableArray*			mElements;
	ECXMLElement*			mParent;
	NSMutableString*		mText;
}

@property (assign, nonatomic) ECXMLElement*			parent;
@property (retain, nonatomic) NSDictionary*			attributes;
@property (retain, nonatomic) NSMutableArray*		elements;
@property (retain, nonatomic) NSMutableDictionary*	properties;
@property (retain, nonatomic) NSString*				name;
@property (retain, nonatomic) NSMutableString*		text;

- (id) initWithName: (NSString*) name attributes: (NSDictionary*) attributes;
- (void) addElement: (ECXMLElement*) element;
- (void) addText: (NSString*) text;
- (void) collapseElementsUsingIndexKey: (NSString*) indexKey withElementName: (BOOL) addElementName;
- (void) collapseElementsByNameUsingIndexKey: (NSString*) indexKey withElementName: (BOOL) addElementName;
- (NSString*) description;

@end
