// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECXMLParser.h"
#import "ECXMLElement.h"

#import "ECLogging.h"
#import "NSURL+ECCore.h"

#pragma mark - Private Interface

@interface ECXMLParser()

@property (nonatomic, retain) ECXMLElement* rootElement;

@end

@implementation ECXMLParser


#pragma mark - Debug Channels

ECDefineDebugChannel(ParsingChannel);
ECDefineDebugChannel(ParsingDetailChannel);

#pragma mark - Properties

@synthesize arrayElements;
@synthesize indexKey;
@synthesize nameKey;
@synthesize valueKey;
@synthesize rootElement;

// --------------------------------------------------------------------------
//! Release retained objects and clean up.
// --------------------------------------------------------------------------

- (void) dealloc
{
	[arrayElements release];
	[indexKey release];
	[nameKey release];
	[valueKey release];
	[rootElement release];
	
	[super dealloc];
}

// --------------------------------------------------------------------------
//! Parse with the supplied NSXMLParser object.
// --------------------------------------------------------------------------

- (NSDictionary*)parseWithParser:(NSXMLParser*)parser
{
	parser.delegate = self;
	NSMutableDictionary* rootAttributes = [[NSMutableDictionary alloc] init];
	ECXMLElement* root = [[ECXMLElement alloc] initWithName: @"root" attributes:rootAttributes];
	[rootAttributes release];
	
	self.rootElement = root;
	[root release];

	mCurrentElement = rootElement;
	
	BOOL ok = [parser parse];
	if (ok)
	{
		[rootElement collapseElementsForParser:self];
		ECDebug(ParsingChannel, @"parsing succeeded");
		ECDebug(ParsingDetailChannel, @"parsing result: %@", rootElement.properties);
	}
	else
	{
		ECDebug(ParsingChannel, @"parsing failed with error %@", [parser parserError]);
	}
	
	return root.properties;
}

// --------------------------------------------------------------------------
//! Parse xml and get list of treasure from it.
// --------------------------------------------------------------------------

- (NSDictionary*)parseData:(NSData*)data;
{
	ECDebug(ParsingChannel, @"parsing data");
	NSXMLParser* parser = [[NSXMLParser alloc] initWithData:data];
	NSDictionary* result = [self parseWithParser:parser];
	[parser release];
	
	return result;
}


// --------------------------------------------------------------------------
//! Parse xml and get list of treasure from it.
// --------------------------------------------------------------------------

- (NSDictionary*)parseContentsOfURL:(NSURL*)url;
{
	ECDebug(ParsingChannel, @"parsing from URL %@", url);
	NSXMLParser* parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	NSDictionary* result = [self parseWithParser:parser];
	[parser release];
	
	return result;
}

// --------------------------------------------------------------------------
//! Handle the beginning of an XML element.
//! We make a new XMLElement object and store the attributes 
//! in it.
// --------------------------------------------------------------------------

- (void)parser:(NSXMLParser*)parser didStartElement:(NSString*)elementName namespaceURI:(NSString*)namespaceURI qualifiedName:(NSString*)qName attributes:(NSDictionary*)attributeDict
{
	ECDebug(ParsingDetailChannel, @"start element %@", elementName);
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
	ECDebug(ParsingDetailChannel, @"found chars %@", string);
	[mCurrentElement addText: string];
}

// --------------------------------------------------------------------------
//! Handle the ending of an XML element.
//! We clean up the current ECXMLElement object, and then
//! the the current element back to its parent.
// --------------------------------------------------------------------------

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	ECDebug(ParsingDetailChannel, @"end element %@", elementName);
	[mCurrentElement collapseElementsForParser:self];
	mCurrentElement = mCurrentElement.parent;
}

@end
