// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 02/08/2011
//
//  Copyright 2012 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

@interface ECMacStoreReceipt : NSObject
{
@private
    NSDictionary* info;

}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

@property (nonatomic, retain) NSDictionary* info;

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (id)initWithURL:(NSURL*)url;

- (BOOL)isValidForGuid:(NSData*)guid identifier:(NSString*)identifier version:(NSString*)version;
- (BOOL)isValidForGuid:(NSData*)guid identifier:(NSString*)identifier;

@end
