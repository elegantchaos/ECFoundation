// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 16/01/2010
//
//  Copyright 2011 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECProperties.h"
#import "ECPreferencePanel.h"

@interface ECSparklePreferenceController : ECPreferencePanel
{
@private
	ECPropertyVariable(introText, NSString*);
	ECPropertyVariable(anonymousText, NSString*);
}

ECPropertyRetained(introText, NSString*);
ECPropertyRetained(anonymousText, NSString*);

@end
