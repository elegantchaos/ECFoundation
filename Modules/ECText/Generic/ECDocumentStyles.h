// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/10/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@interface ECDocumentStyles : NSObject

@property (nonatomic, retain) NSString* plainFont;
@property (nonatomic, retain) NSString* boldFont;
@property (nonatomic, retain) NSString* headingFont;
@property (nonatomic, retain) NSString* italicFont;

@property (nonatomic, assign) CGFloat plainSize;
@property (nonatomic, assign) CGFloat headingSize;

@property (nonatomic, assign) CGColorRef colour;
@property (nonatomic, assign) CGColorRef linkColour;

@end

@interface UILabel(ECDocumentStyles)

- (ECDocumentStyles*)defaultStyles;

@end

@interface UITextField(ECDocumentStyles)

- (ECDocumentStyles*)defaultStyles;

@end

@interface UITextView(ECDocumentStyles)

- (ECDocumentStyles*)defaultStyles;

@end

