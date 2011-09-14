// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECXMLElement.h"
#import "ECXMLParser.h"

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

- (void) collapseElementsForParser:(ECXMLParser *)parser
{
	// add any attributes to the properties dictionary for the element
	self.properties = [NSMutableDictionary dictionaryWithDictionary: mAttributes];
	
	// iterate through sub-elements
	for (ECXMLElement* element in mElements)
	{
		// try to get a key for the sub-element
		NSString* elementKey = nil;
		if (parser.indexKey != nil)
		{
			elementKey = [element.properties valueForKey: parser.indexKey];
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
			if (parser.nameKey)
			{
				[element.properties setValue: element.name forKey:parser.nameKey];
			}
			if (element.text && parser.valueKey)
			{
				[element.properties setValue: element.text forKey:parser.valueKey];
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
				// if it has just one property and it matches an item in the arrayElements array
				// we just store the property value as an array, and skip a level of element names
				BOOL treatedAsArray = NO;
				if ([element.properties count] == 1)
				{
					NSString* arrayKey = [parser.arrayElements objectForKey:element.name];
					if (arrayKey)
					{
						NSObject* value = [element.properties objectForKey:arrayKey];
						if (value)
						{
							if (![value isKindOfClass:[NSArray class]])
							{
								value = [NSArray arrayWithObject:value];
							}

							[mProperties setValue:value forKey:elementKey];
							treatedAsArray = YES;
						}
					}
				}
				
				if (!treatedAsArray)
				{
					[mProperties setValue: element.properties forKey: elementKey];
				}
			}
			else
			{
				[mProperties setValue: element.text forKey: elementKey];
			}

		}

	}
	self.elements = nil;
	
}


- (NSString*) description
{
	return [NSString stringWithFormat:@"\nname:%@\nproperties:%@", mName, mProperties];
}

@end
