// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 28/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECLabelValueTableController.h"

@interface ECDebugViewController : ECLabelValueTableController 
{
	ECPropertyVariable(channels, ECDataItem*);
}

ECPropertyRetained(channels, ECDataItem*);

@end
