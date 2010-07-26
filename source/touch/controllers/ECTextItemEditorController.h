//
//  Class.h
//  ECFoundation
//
//  Created by Sam Deane on 26/07/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ECDataDrivenView.h"

@interface ECTextItemEditorController : UIViewController<ECDataDrivenView>
{
	ECPropertyDefineVariable(data, ECDataItem*);
    
}

// --------------------------------------------------------------------------
// Public Properties
// --------------------------------------------------------------------------

ECPropertyDefineRN(data, ECDataItem*);

@end
