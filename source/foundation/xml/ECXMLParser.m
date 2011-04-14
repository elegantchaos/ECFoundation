// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECXMLParser.h"
#import "ECXMLElement.h"

#import <ECFoundation/NSURL+ECUtilities.h>

@interface ECXMLParser()

ECPropertyRetained(rootElement, ECXMLElement*);

@end

@implementation ECXMLParser

ECDefineDebugChannel(ParsingChannel);

// --------------------------------------------------------------------------
// Constants
// --------------------------------------------------------------------------

// --------------------------------------------------------------------------
// Synthesized properties.
// --------------------------------------------------------------------------

ECPropertySynthesize(rootElement);

// --------------------------------------------------------------------------
//! Release retained objects and clean up.
// --------------------------------------------------------------------------

- (void) dealloc
{
	ECPropertyDealloc(rootElement);
	
	[super dealloc];
}

// --------------------------------------------------------------------------
//! Parse xml and get list of treasure from it.
// --------------------------------------------------------------------------

- (NSDictionary*)parse:(NSData*)data;
{
	NSXMLParser* parser = [[NSXMLParser alloc] initWithData:data];
	parser.delegate = self;
	
	NSMutableDictionary* rootAttributes = [[NSMutableDictionary alloc] init];
	ECXMLElement* rootElement = [[ECXMLElement alloc] initWithName: @"root" attributes: rootAttributes];
	self.rootElement = rootElement;
	[rootElement release];
	mCurrentElement = rootElement;
	
	BOOL ok = [parser parse];
	if (ok)
	{
		[rootElement collapseElementsUsingIndexKey: nil withElementName: NO];
	}
	if (!ok)
	{
		ECDebug(ParsingChannel, @"parsing failed");
	}
	
	[parser release];

	return [rootAttributes autorelease];
}

// --------------------------------------------------------------------------
//! Handle the beginning of an XML element.
//! We make a new XMLElement object and store the attributes 
//! in it.
// --------------------------------------------------------------------------

- (void)parser:(NSXMLParser*)parser didStartElement:(NSString*)elementName namespaceURI:(NSString*)namespaceURI qualifiedName:(NSString*)qName attributes:(NSDictionary*)attributeDict
{
	ECDebug(ParsingChannel, @"start element %@", elementName);
	ECXMLElement* element = [[ECXMLElement alloc] initWithName:elementName attributes:attributeDict];
	[mCurrentElement addElement: element];
	mCurrentElement = element;
	[element release];
}

// --------------------------------------------------------------------------
//! Handle some content text inside an XML element.
//! We just concatenate it to the existing XmlElement object.
// --------------------------------------------------------------------------

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	ECDebug(ParsingChannel, @"found chars %@", string);
	[mCurrentElement addText: string];
}

// --------------------------------------------------------------------------
//! Handle the ending of an XML element.
//! We clean up the current ECXMLElement object, and then
//! the the current element back to its parent.
// --------------------------------------------------------------------------

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	ECDebug(ParsingChannel, @"end element %@", elementName);
	[mCurrentElement collapseElementsUsingIndexKey: nil withElementName: YES];
	mCurrentElement = mCurrentElement.parent;
}

@end
