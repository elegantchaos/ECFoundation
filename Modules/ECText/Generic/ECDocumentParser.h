// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/10/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@class ECDocumentStyles;

@interface ECDocumentParser : NSObject

#pragma mark - Public Properties

@property (nonatomic, retain) ECDocumentStyles* styles;
@property (nonatomic, retain) NSDictionary* attributesBold;
@property (nonatomic, retain) NSDictionary* attributesItalic;
@property (nonatomic, retain) NSDictionary* attributesPlain;

#pragma mark - Public Methods

- (id)initWithStyles:(ECDocumentStyles*)styles;
- (void)initialiseAttributes;

@end
