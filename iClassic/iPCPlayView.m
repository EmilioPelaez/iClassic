//
//  iPCPlayView.m
//  iClassic
//
//  Created by Emilio Peláez on 6/11/15.
//  Copyright © 2015 Emilio Peláez. All rights reserved.
//

#import "iPCPlayView.h"

@implementation iPCPlayView

-(void)drawRect:(CGRect)rect{
	UIBezierPath* playPath = UIBezierPath.bezierPath;
	[playPath moveToPoint: CGPointMake(4.5, 4)];
	[playPath addLineToPoint: CGPointMake(4.5, 10)];
	[playPath addCurveToPoint: CGPointMake(10.5, 7) controlPoint1: CGPointMake(4.5, 10.18) controlPoint2: CGPointMake(10.5, 7)];
	[playPath addCurveToPoint: CGPointMake(4.5, 4) controlPoint1: CGPointMake(10.5, 7) controlPoint2: CGPointMake(4.5, 3.82)];
	[playPath closePath];
	[playPath moveToPoint: CGPointMake(7, 0)];
	[playPath addCurveToPoint: CGPointMake(0, 7) controlPoint1: CGPointMake(3.13, 0) controlPoint2: CGPointMake(0, 3.13)];
	[playPath addCurveToPoint: CGPointMake(7, 14) controlPoint1: CGPointMake(0, 10.87) controlPoint2: CGPointMake(3.13, 14)];
	[playPath addCurveToPoint: CGPointMake(14, 7) controlPoint1: CGPointMake(10.87, 14) controlPoint2: CGPointMake(14, 10.87)];
	[playPath addCurveToPoint: CGPointMake(7, 0) controlPoint1: CGPointMake(14, 3.13) controlPoint2: CGPointMake(10.87, 0)];
	[playPath closePath];
	[playPath moveToPoint: CGPointMake(7, 13)];
	[playPath addCurveToPoint: CGPointMake(1, 7) controlPoint1: CGPointMake(3.49, 13) controlPoint2: CGPointMake(1, 10.51)];
	[playPath addCurveToPoint: CGPointMake(7, 1) controlPoint1: CGPointMake(1, 3.49) controlPoint2: CGPointMake(3.49, 1)];
	[playPath addCurveToPoint: CGPointMake(13, 7) controlPoint1: CGPointMake(10.51, 1) controlPoint2: CGPointMake(13, 3.49)];
	[playPath addCurveToPoint: CGPointMake(7, 13) controlPoint1: CGPointMake(13, 10.51) controlPoint2: CGPointMake(10.51, 13)];
	[playPath closePath];
	playPath.miterLimit = 4;
	
	[[UIColor flatBlackColor] setFill];
	[playPath fill];
}

@end
