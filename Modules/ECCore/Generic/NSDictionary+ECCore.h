// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 12/04/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

@interface NSDictionary (ECCore)

- (id) valueForKey: (NSString*) key intoBool: (BOOL*) valueOut;
- (id) valueForKey: (NSString*) key intoDouble: (double*) valueOut;

- (CGPoint)pointForKey:(NSString*)key;
- (CGSize)sizeForKey:(NSString*)key;
- (CGRect)rectForKey:(NSString*)key;

- (NSDictionary*)dictionaryWithoutKey:(NSString*)key;

@end

@interface NSMutableDictionary (ECCore)

- (void)setPoint:(CGPoint)point forKey:(NSString*)key;
- (void)setSize:(CGSize)size forKey:(NSString*)key;
- (void)setRect:(CGRect)rect forKey:(NSString*)key;

- (void)mergeEntriesFromDictionary:(NSDictionary*)dictionary;

@end
