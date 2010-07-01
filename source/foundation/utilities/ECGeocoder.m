// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 01/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGeocoder.h"

@implementation ECGeocoder

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
	}
	ECDebug(@"received response: type:%@ length:%lld encoding: %@ (%d)", [response MIMEType], [response expectedContentLength], encodingName, (int) mEncoding);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	ECDebug(@"received data: %@", [[NSString alloc] initWithData: data encoding: mEncoding]);
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
{
	ECDebug(@"failed");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{
	ECDebug(@"finished");
}

@end
