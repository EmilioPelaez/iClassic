//
//  iPCMainViewController.h
//  iClassic
//
//  Created by Emilio Peláez on 4/30/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "iPCView.h"
#import "iPCBackgroundView.h"
#import "iPCDisplayStack.h"
#import "iPCClickWheel.h"

@interface iPCMainViewController : UIViewController{
	__weak IBOutlet UIView *referenceDisplayView;
	__weak IBOutlet NSLayoutConstraint *displayHeightConstraint;
	__weak IBOutlet NSLayoutConstraint *displayTopMarginConstraint;
	__weak IBOutlet NSLayoutConstraint *displayBottomMarginConstraint;
}

@property(nonatomic, strong) iPCDisplayStack *displayStack;
@property(nonatomic, weak) IBOutlet iPCClickWheel *clickWheelView;

@property(nonatomic, weak) IBOutlet iPCView *iPodView;

@end
