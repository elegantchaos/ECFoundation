// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECXMLElement.h"


@implementation ECXMLElement

@synthesize attributes = mAttributes;
@synthesize elements = mElements;
@synthesize name = mName;
@synthesize parent = mParent;
@synthesize properties = mProperties;
@synthesize text = mText;

- (id) initWithName: (NSString*) name attributes: (NSDictionary*) attributes
{
	if ((self = [super init]) != nil)
	{
		self.name = name;
		self.attributes = attributes;
	}
	
	return self;
}

- (void) dealloc
{
	[mAttributes release];
	[mElements release];
	[mName release];
	[mProperties release];
	[mText release];
	
	[super dealloc];
}

- (void) addElement: (ECXMLElement*) element
{
	if (mElements == nil)
	{
		mElements = [[NSMutableArray alloc] init];
	}
	
	[mElements addObject: element];
	element.parent = self;
}

- (void) addText: (NSString*) text
{
	if (mText == nil)
	{
		mText = [[NSMutableString alloc] init];
	}
	
	[mText appendString: text];
}

- (void) collapseElementsUsingIndexKey: (NSString*) indexKey withElementName: (BOOL) addElementName
{
	// add any attributes to the properties dictionary for the element
	self.properties = [NSMutableDictionary dictionaryWithDictionary: mAttributes];
	
	// iterate through sub-elements
	for (ECXMLElement* element in mElements)
	{
		// try to get a key for the sub-element
		NSString* elementKey = nil;
		if (indexKey != nil)
		{
			elementKey = [element.properties valueForKey: indexKey];
		}
		if (!elementKey)
		{
			elementKey = element.name;
		}
		
		// if the sub-element already has properties, we possibly add
		// the element name and element value properties as meta-data
		BOOL gotProperties = [element.properties count] > 0;
		if (gotProperties)
		{
			if (addElementName)
			{
				[element.properties setValue: element.name forKey: @"element-name"];
			}
			if (element.text)
			{
				[element.properties setValue: element.text forKey: @"element-value"];
			}
		}

		// if there is already an entry using the same key as this sub-element, check to see if the entry contains an array
		// if it does, we just add the new sub-element to the array; if not, we make an array, add the existing entry to it, then
		// add this sub-element as well
		id existing = [mProperties objectForKey: elementKey];
		if (existing != nil)
		{
			NSMutableArray* array;
			if ([existing isKindOfClass: [NSMutableArray class]])
			{
				array = (NSMutableArray*) existing;
			}
			else
			{
				array = [NSMutableArray arrayWithObject: existing];
				[mProperties setValue: array forKey: elementKey];
			}
			
			[array addObject: element.properties];
		}
		
		// if there's no existing entry we just add one; we use a dictionary for the value if the sub-element has properties,
		// otherwise we just use the text value of the element
		else
		{
			if (gotProperties)
			{
				[mProperties setValue: element.properties forKey: elementKey];
			}
			else
			{
				[mProperties setValue: element.text forKey: elementKey];
			}

		}

	}
	self.elements = nil;
}

- (void) collapseElementsByNameUsingIndexKey: (NSString*) indexKey withElementName: (BOOL) addElementName
{
	self.properties = [NSMutableDictionary dictionaryWithDictionary: mAttributes];
	for (ECXMLElement* element in mElements)
	{
		NSString* elementKey = nil;
		if (indexKey != nil)
		{
			elementKey = [element.properties valueForKey: indexKey];
		}

		if (elementKey)
		{
			NSMutableDictionary* kindDictionary = [mProperties objectForKey: element.name];
			if (!kindDictionary)
			{
				kindDictionary = [NSMutableDictionary dictionary];
				[mProperties setObject: kindDictionary forKey: element.name];
			}
			
			if ([element.properties count] > 0)
			{
				if (addElementName)
				{
					[element.properties setValue: element.name forKey: @"element-name"];
				}
				if (element.text)
				{
					[element.properties setValue: element.text forKey: @"element-value"];
				}
				[kindDictionary setValue: element.properties forKey: elementKey];
			}
			else
			{
				[kindDictionary setValue: element.text forKey: elementKey];
			}
		}
		else
		{
			[self collapseElementsUsingIndexKey:indexKey withElementName: addElementName];
		}

		
	}
	self.elements = nil;
}

- (NSString*) description
{
	return [NSString stringWithFormat:@"\nname:%@\nproperties:%@", mName, mProperties];
}

@end
