//
//  ECGradientButton.h
//  pod point
//
//  Created by Sam Deane on 02/09/2010.
//  Copyright 2010 Elegant Chaos. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CAGradientLayer;

@interface ECGradientButton : UIButton 
{

}

ECPropertyRetained(topColour, UIColor*);
ECPropertyRetained(bottomColour, UIColor*);
ECPropertyRetained(gradient, CAGradientLayer*);

- (void) updateColours;

@end
