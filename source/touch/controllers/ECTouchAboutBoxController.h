//
//  ECAboutBoxController.h
//  ECFoundation
//
//  Created by Sam Deane on 28/07/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECTouchAboutBoxController : UIViewController 
{
    ECPropertyDefineVariable(application, UILabel*);
    ECPropertyDefineVariable(version, UILabel*);
    ECPropertyDefineVariable(about, UITextField*);
    ECPropertyDefineVariable(copyright, UILabel*);
}

ECPropertyDefineRN(application, IBOutlet UILabel*);
ECPropertyDefineRN(version, IBOutlet UILabel*);
ECPropertyDefineRN(about, IBOutlet UITextField*);
ECPropertyDefineRN(copyright, IBOutlet UILabel*);

@end
