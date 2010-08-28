// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 28/07/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <UIKit/UIKit.h>

@interface ECTouchAboutBoxController : UIViewController 
{
    ECPropertyDefineVariable(application, UILabel*);
    ECPropertyDefineVariable(version, UILabel*);
    ECPropertyDefineVariable(about, UITextField*);
    ECPropertyDefineVariable(copyright, UILabel*);
    ECPropertyDefineVariable(logo, UIImageView*);
}

ECPropertyRetained(application, IBOutlet UILabel*);
ECPropertyRetained(version, IBOutlet UILabel*);
ECPropertyRetained(about, IBOutlet UITextField*);
ECPropertyRetained(copyright, IBOutlet UILabel*);
ECPropertyRetained(logo, IBOutlet UIImageView*);

@end
