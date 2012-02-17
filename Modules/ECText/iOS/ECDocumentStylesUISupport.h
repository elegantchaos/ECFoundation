// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/10/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECDocumentStyles.h"

@class ECDocumentStyles;
@class UIFont;

@interface ECDocumentStyles(UISupport)

- (id)initWithFont:(UIFont*)font colour:(UIColor*)colourIn;

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

