// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@interface NSData(ECSha1)
- (NSString*) sha1Digest;
@end

@interface NSString(ECSha1)
- (NSString*)sha1Digest;
@end

@interface NSURL(ECSha1)
- (NSString*)sha1Digest;
@end