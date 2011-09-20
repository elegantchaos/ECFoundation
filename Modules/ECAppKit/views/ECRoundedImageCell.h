// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 18/12/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's 
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECProperties.h"

@interface ECRoundedImageCell : NSImageCell 
{
	ECPropertyVariable(cornerRadius, CGFloat);
}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

ECPropertyAssigned(cornerRadius, CGFloat);

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

@end
