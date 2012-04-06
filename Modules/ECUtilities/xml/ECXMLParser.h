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
	ECXMLElement* rootElement;
	NSString* indexKey;
	NSString* nameKey;
	NSString* valueKey;
	NSDictionary* arrayElements;

	ECXMLElement*			mCurrentElement;

}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

@property (strong, nonatomic) NSString* indexKey;
@property (strong, nonatomic) NSString* nameKey;
@property (strong, nonatomic) NSString* valueKey;
@property (strong, nonatomic) NSDictionary* arrayElements;

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (NSDictionary*)parseData:(NSData*)data;
- (NSDictionary*)parseContentsOfURL:(NSURL*)url;

@end
