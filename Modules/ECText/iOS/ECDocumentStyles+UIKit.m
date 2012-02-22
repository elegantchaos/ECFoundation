// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/10/2011
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECDocumentStyles+UIKit.h"
#import "ECDocumentStyles.h"
#import "UIFont+ECCore.h"

@implementation ECDocumentStyles(UIKit)

- (id)initWithFont:(UIFont*)font colour:(UIColor*)colourIn
{
if ((self = [super init]) != nil)
{
	self.plainFont = font.fontName;
	self.plainSize = font.pointSize;
	self.boldFont = [font boldVariant].fontName;
	self.italicFont = [font italicVariant].fontName;
	self.headingFont = self.boldFont;
	self.headingSize = font.pointSize + 2.0;
	self.colour = colourIn.CGColor;
	self.linkColour = [UIColor blueColor].CGColor;
}

return self;
}

@end

@implementation UILabel(ECDocumentStyles)

// --------------------------------------------------------------------------
//! Return some default styles based on the current font
//! setting for the underlying UILabel.
// --------------------------------------------------------------------------

- (ECDocumentStyles*)defaultStyles
{
    ECDocumentStyles* styles = [[ECDocumentStyles alloc] initWithFont:self.font colour:self.textColor];
	
	return [styles autorelease];
}

@end

@implementation UITextField(ECDocumentStyles)

// --------------------------------------------------------------------------
//! Return some default styles based on the current font
//! setting for the underlying UILabel.
// --------------------------------------------------------------------------

- (ECDocumentStyles*)defaultStyles
{
	ECDocumentStyles* styles = [[ECDocumentStyles alloc] initWithFont:self.font colour:self.textColor];
	
	return [styles autorelease];
}

@end

@implementation UITextView(ECDocumentStyles)

// --------------------------------------------------------------------------
//! Return some default styles based on the current font
//! setting for the underlying UILabel.
// --------------------------------------------------------------------------

- (ECDocumentStyles*)defaultStyles
{
ECDocumentStyles* styles = [[ECDocumentStyles alloc] initWithFont:self.font colour:self.textColor];

return [styles autorelease];
}

@end
