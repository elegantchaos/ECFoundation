// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

@class ECXMLElement;


// --------------------------------------------------------------------------
//! Helper object which manages fetching treasure data from
//! an xml description at a URL.
// --------------------------------------------------------------------------

@interface ECXMLParser : NSObject<NSXMLParserDelegate>
{
	ECPropertyVariable(rootElement, ECXMLElement*);
	ECPropertyVariable(indexKey, NSString*);
	ECPropertyVariable(nameKey, NSString*);
	ECPropertyVariable(valueKey, NSString*);
	ECPropertyVariable(arrayElements, NSDictionary*);

	ECXMLElement*			mCurrentElement;
}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

ECPropertyRetained(indexKey, NSString*);
ECPropertyRetained(nameKey, NSString*);
ECPropertyRetained(valueKey, NSString*);
ECPropertyRetained(arrayElements, NSDictionary*);

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (NSDictionary*)parseData:(NSData*)data;
- (NSDictionary*)parseContentsOfURL:(NSURL*)url;

@end
