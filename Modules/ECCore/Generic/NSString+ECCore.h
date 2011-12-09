// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Created by Sam Deane on 11/08/2010.
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>


@interface NSString(ECCore)

- (BOOL)containsString:(NSString*)string;
- (BOOL)beginsWithString:(NSString*)string;
- (BOOL)endsWithString:(NSString*)string;

- (NSData*)splitWordsIntoInts;
- (NSData*)splitWordsIntoFloats;
- (NSData*)splitWordsIntoDoubles;
- (NSArray*)componentsSeparatedByMixedCaps;

- (NSString*)stringBySplittingMixedCaps;

+ (NSString*)stringByFormattingCount:(NSUInteger)count singularFormat:(NSString*)singularFormat pluralFormat:(NSString*)pluralFormat;
+ (NSString*)stringWithMixedCapsFromWords:(NSArray*)words initialCap:(BOOL)initialCap;
+ (NSString*)stringWithUppercaseFromWords:(NSArray*)words separator:(NSString*)separator;
+ (NSString*)stringWithLowercaseFromWords:(NSArray*)words separator:(NSString*)separator;
+ (NSString*)stringWithNewUUID;


+ (NSString*)stringWithOrdinal:(NSInteger)ordinal;

- (NSString*)truncateToLength:(NSUInteger)length;

@end
