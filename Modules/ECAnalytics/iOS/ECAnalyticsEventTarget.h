// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 15/11/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@protocol ECAnalyticsEventTarget

- (void)analyticsAddDefaultParametersForEvent:(NSString*)event toDictionary:(NSMutableDictionary*) dictionary;
- (void)analyticsAddDynamicParametersForEvent:(NSString*)event toDictionary:(NSMutableDictionary*) dictionary;

@end
