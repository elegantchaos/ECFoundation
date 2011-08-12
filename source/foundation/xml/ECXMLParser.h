// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECProperties.h"

@class ECXMLElement;


// --------------------------------------------------------------------------
//! Helper object which manages fetching treasure data from
//! an xml description at a URL.
// --------------------------------------------------------------------------

@interface ECXMLParser : NSObject<NSXMLParserDelegate>
{
	ECXMLElement*			mCurrentElement;

	ECPropertyVariable(indexKey, NSString*);
	ECPropertyVariable(nameKey, NSString*);
	ECPropertyVariable(valueKey, NSString*);
	ECPropertyVariable(arrayElements, NSDictionary*);
	ECPropertyVariable(rootElement, ECXMLElement*);

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
