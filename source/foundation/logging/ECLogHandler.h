// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 01/08/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@interface ECLogHandler : NSObject 
{
    ECPropertyVariable(name, NSString*);
}

ECPropertyRetained(name, NSString*);

- (void) logFromChannel: (ECLogChannel*) channel withFormat: (NSString*) format arguments: (va_list) arguments;
- (NSComparisonResult) caseInsensitiveCompare: (ECLogHandler*) other;

@end
