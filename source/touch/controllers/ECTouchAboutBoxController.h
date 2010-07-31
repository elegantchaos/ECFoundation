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

ECPropertyDefineRN(application, IBOutlet UILabel*);
ECPropertyDefineRN(version, IBOutlet UILabel*);
ECPropertyDefineRN(about, IBOutlet UITextField*);
ECPropertyDefineRN(copyright, IBOutlet UILabel*);
ECPropertyDefineRN(logo, IBOutlet UIImageView*);

@end
