// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 01/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGeocoder.h"
#import "ECGeocoderPoint.h"
#import "JSON.h"

@implementation ECGeocoder

@synthesize delegate = mDelegate;

// http://geocoding.cloudmade.com/BC9A493B41014CAABB98F0471D759707/geocoding/v2/find.js?query=croxted%20road

static const NSString* kCloudMadeBase = @"http://geocoding.cloudmade.com";
static const NSString* kCloudMadeID = @"BC9A493B41014CAABB98F0471D759707";
static const NSString* kCloudMadeQuery = @"geocoding/v2/find.js?query=";

- (void) lookup: (NSString*) stringToLookup
{
	NSString* query = [NSString stringWithFormat: @"%@/%@/%@%@", kCloudMadeBase, kCloudMadeID, kCloudMadeQuery, stringToLookup];
	ECDebug(@"geocoding request: %@", query);
	
	NSURLRequest* request = [NSURLRequest requestWithURL: [NSURL URLWithString:query]];
	NSURLConnection* connection = [NSURLConnection connectionWithRequest: request delegate:self];
	ECUnused(connection);
	
	
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	NSString* encodingName = [response textEncodingName];
	if (encodingName)
	{
		mEncoding = CFStringConvertEncodingToNSStringEncoding(CFStringConvertIANACharSetNameToEncoding((CFStringRef) encodingName));
		mRawJSON = [[NSMutableString alloc] init];
	}

	ECDebug(@"received response: type:%@ length:%lld encoding: %@ (%d)", [response MIMEType], [response expectedContentLength], encodingName, (int) mEncoding);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	NSString* text = [[NSString alloc] initWithData: data encoding: mEncoding];

	if (mRawJSON)
	{
		[mRawJSON appendString: text];
	}
	
	ECDebug(@"received data: %@", text);
	[text release];
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
{
	ECDebug(@"failed");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{
	NSDictionary* value = [mRawJSON JSONValue];
	ECDebug(@"got data:\n%@", value);

	if (mDelegate)
	{
		NSMutableArray* points = [[NSMutableArray alloc] init];
		NSArray* features = [value valueForKey: @"features"];
		for (NSDictionary* feature in features)
		{
			NSDictionary* centroid = [feature valueForKey: @"centroid"];
			NSArray* centre = [centroid valueForKey: @"coordinates"];
			CLLocationCoordinate2D location;
			location.latitude = [[centre objectAtIndex: 0] doubleValue];
			location.longitude = [[centre objectAtIndex: 1] doubleValue];

			ECGeocoderPoint* point = [[ECGeocoderPoint alloc] initWithLocation: location andData: feature];
			[points addObject: point];
			[point release];
		}
		
		[mDelegate geocoder:self foundPoints:points];
		[points release];
	}
}

@end
