//
//  NSString+ECUtilities.h
//  ECFoundation
//
//  Created by Sam Deane on 11/08/2010.
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
//

#import <Foundation/Foundation.h>


@interface NSString(ECUtilities)

- (NSData*)splitWordsIntoInts;
- (NSData*)splitWordsIntoFloats;
- (NSString*)stringBySplittingMixedCaps;
+ (NSString*)stringByFormattingCount:(NSUInteger)count singularFormat:(NSString*)singularFormat pluralFormat:(NSString*)pluralFormat;

+ (NSString*)stringWithNewUUID;

- (NSString*)sha1Digest;

+ (NSString*)stringWithOrdinal:(NSInteger)ordinal;

@end
