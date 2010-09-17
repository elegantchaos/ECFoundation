// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 28/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <UIKit/UIKit.h>

@interface ECTouchAboutBoxController : UIViewController 
{
    ECPropertyVariable(application, UILabel*);
    ECPropertyVariable(version, UILabel*);
    ECPropertyVariable(about, UITextField*);
    ECPropertyVariable(copyright, UILabel*);
    ECPropertyVariable(logo, UIImageView*);
}

ECPropertyRetained(application, IBOutlet UILabel*);
ECPropertyRetained(version, IBOutlet UILabel*);
ECPropertyRetained(about, IBOutlet UITextField*);
ECPropertyRetained(copyright, IBOutlet UILabel*);
ECPropertyRetained(logo, IBOutlet UIImageView*);

@end
