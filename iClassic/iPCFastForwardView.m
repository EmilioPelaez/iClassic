//
//  iPCFastForwardView.m
//  iClassic
//
//  Created by Emilio Peláez on 6/12/15.
//  Copyright © 2015 Emilio Peláez. All rights reserved.
//

#import "iPCFastForwardView.h"

@implementation iPCFastForwardView

-(void)tintColorDidChange{
	[super tintColorDidChange];
	
	[self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect {
	[self.tintColor setStroke];
	
	UIBezierPath* arrowPath = UIBezierPath.bezierPath;
	[arrowPath moveToPoint: CGPointMake(0.5, 0.5)];
	[arrowPath addLineToPoint: CGPointMake(0.5, 8.5)];
	[arrowPath addLineToPoint: CGPointMake(7.5, 4.5)];
	[arrowPath addLineToPoint: CGPointMake(0.5, 0.5)];
	[arrowPath closePath];
	arrowPath.lineWidth = 1;
	[arrowPath stroke];
	
	UIBezierPath* arrow2Path = UIBezierPath.bezierPath;
	[arrow2Path moveToPoint: CGPointMake(8.5, 0.5)];
	[arrow2Path addLineToPoint: CGPointMake(8.5, 8.5)];
	[arrow2Path addLineToPoint: CGPointMake(15.5, 4.5)];
	[arrow2Path addLineToPoint: CGPointMake(8.5, 0.5)];
	[arrow2Path closePath];
	arrow2Path.lineWidth = 1;
	[arrow2Path stroke];
}

@end
